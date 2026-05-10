//
//  RemoteImageView.swift
//  DeltaGames
//
//  Created by GitHub Copilot on 09/05/26.
//

import SwiftUI
import Combine

private final class ImageLoader: ObservableObject {
  @Published var image: UIImage?

  private static let cache = NSCache<NSURL, UIImage>()
  private var cancellable: AnyCancellable?
  private var hasLoaded = false
  private let url: URL?

  init(url: URL?) {
    self.url = url
  }

  func loadIfNeeded() {
    guard !hasLoaded else { return }
    hasLoaded = true

    guard let url else { return }

    if let cached = Self.cache.object(forKey: url as NSURL) {
      image = cached
      return
    }

    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] downloadedImage in
        guard let self else { return }
        guard let downloadedImage else { return }
        Self.cache.setObject(downloadedImage, forKey: url as NSURL)
        self.image = downloadedImage
      }
  }

  deinit {
    cancellable?.cancel()
  }
}

struct RemoteImageView<Placeholder: View>: View {
  @StateObject private var loader: ImageLoader
  private let placeholder: Placeholder
  private let contentMode: ContentMode

  init(
    url: URL?,
    contentMode: ContentMode = .fill,
    @ViewBuilder placeholder: () -> Placeholder
  ) {
    _loader = StateObject(wrappedValue: ImageLoader(url: url))
    self.contentMode = contentMode
    self.placeholder = placeholder()
  }

  var body: some View {
    Group {
      if let image = loader.image {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: contentMode)
      } else {
        placeholder
      }
    }
    .onAppear {
      loader.loadIfNeeded()
    }
  }
}
