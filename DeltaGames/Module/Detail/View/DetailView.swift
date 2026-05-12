//
//  DetailView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import SwiftUI

struct DetailView: View {
  @AppStorage("app_language") private var appLanguageCode: String = AppLanguage.system.rawValue
  @StateObject var presenter: DetailPresenter
  @State private var hasInitialized = false
  private let onDismiss: ((FavoriteChange?) -> Void)?

  init(presenter: DetailPresenter, onDismiss: ((FavoriteChange?) -> Void)? = nil) {
    _presenter = StateObject(wrappedValue: presenter)
    self.onDismiss = onDismiss
  }

  var body: some View {
    Group {
      if presenter.loadingState {
        ProgressView()
      } else if presenter.errorMessage != "" {
        Text(presenter.errorMessage)
      } else {
        detailView
      }
    }
    .onAppear {
      if !hasInitialized {
        hasInitialized = true
        DispatchQueue.main.async {
          presenter.loadIfNeeded()
        }
      }
    }
    .onDisappear {
      DispatchQueue.main.async {
        onDismiss?(presenter.pendingFavoriteChange)
      }
    }
  }
}

extension DetailView {
    var detailView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                  RemoteImageView(
                    url: URL(string: presenter.game.imageBackground ?? "https://i.ibb.co/1GcrfqQ/img-error.png"),
                    contentMode: .fill
                  ) {
                    ZStack {
                      Color(.systemGray5)
                      ProgressView()
                    }
                  }
                    .opacity(0.75)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                    .clipped()
                    Button {
                        if presenter.isFav {
                          presenter.delFavGame(from: "\(presenter.game.id)")
                        } else {
                          presenter.addFavGame(from: GameModel(id: presenter.game.id,
                                                               slug: presenter.game.slug,
                                                               name: presenter.game.name,
                                                               description: presenter.game.description,
                                                               released: presenter.game.released ?? "-",
                                                               imageBackground: presenter.game.imageBackground ?? "https://i.ibb.co/1GcrfqQ/img-error.png",
                                                               rating: presenter.game.rating ?? 0.0,
                                                               ratingTop: presenter.game.ratingTop ?? 0,
                                                               ratingsCount: presenter.game.ratingsCount ?? 0,
                                                               genres: presenter.game.genres,
                                                               parentPlatforms: presenter.game.parentPlatforms,
                                                               tags: presenter.game.tags
                                                          ))
                        }
                    } label: {
                      Image(systemName: presenter.isFav ? "heart.circle.fill" : "heart.circle").font(.system(size: 36))
                            .foregroundColor(presenter.isFav ? .pink : .white)
                            .padding()
                    }
                }
                HStack {
                    Text(presenter.game.name)
                        .padding()
                        .font(Font.title2.weight(.bold))
                        .lineLimit(2)
                    Spacer(minLength: 10)
                    Label(presenter.game.rating.formattedRating(), systemImage: String.SFSymbol.starFill.rawValue)
                        .padding(.horizontal)
                        .font(Font.headline.weight(.bold))
                        .foregroundColor(.primary)
                }
                HStack(spacing: 4) {
                  Text(L10n.text("detail.released"))
                  Text(presenter.game.released ?? "-")
                }
                .padding(.horizontal)
                .font(.caption)
                .foregroundColor(.appPrimary)
                Text((presenter.game.parentPlatforms ?? []).map { $0.platform.name }.joined(separator: ", "))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                    .foregroundColor(Color.gray)
                Text((presenter.game.genres ?? []).map { $0.name }.joined(separator: ", "))
                    .padding(.horizontal)
                    .font(.headline)
                  .foregroundColor(.appPrimary)
                HStack(spacing: 4) {
                  Text(L10n.text("detail.tags"))
                  Text((presenter.game.tags ?? []).map { $0.name }.joined(separator: ", "))
                }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                Text(L10n.text("detail.description"))
                    .padding(.horizontal)
                    .font(.headline)
                  .foregroundColor(.appPrimary)
                Text(removeHTML(string: presenter.game.description ?? ""))
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .font(.headline)
                Spacer()
            }
        }
    }
    func removeHTML(string: String) -> String {
        return (string.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)).replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
}
