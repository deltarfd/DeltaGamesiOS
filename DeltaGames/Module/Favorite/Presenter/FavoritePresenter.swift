//
//  FavoritePresenter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI
import Combine

extension Notification.Name {
  static let favoritesDidChange = Notification.Name("favoritesDidChange")
}

@MainActor
final class FavoritePresenter: ObservableObject {
  private var favoritesRequest: AnyCancellable?
  private var favoritesChangeObserver: AnyCancellable?
  private let router = FavoriteRouter()
  private let favoriteUseCase: FavoriteUseCase
  private var shouldRefreshOnAppear = false

  @Published var favGames: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
    observeFavoriteChanges()
  }

  func handleAppear() {
    if favGames.isEmpty {
      getFavGames(showsLoading: true)
      return
    }

    guard shouldRefreshOnAppear else { return }
    shouldRefreshOnAppear = false
    getFavGames(showsLoading: false)
  }
  
  func refreshFavorites(showsLoading: Bool = false) {
    getFavGames(showsLoading: showsLoading)
  }

  func applyFavoriteChange(_ change: FavoriteChange?) {
    guard let change else { return }

    errorMessage = ""
    if change.isFavorite {
      if let index = favGames.firstIndex(where: { $0.id == change.game.id }) {
        favGames[index] = change.game
      } else {
        favGames.insert(change.game, at: 0)
      }
      return
    }

    favGames.removeAll { $0.id == change.game.id }
  }

  private func getFavGames(showsLoading: Bool) {
    favoritesRequest?.cancel()
    errorMessage = ""
    if showsLoading {
      loadingState = true
    }
    favoritesRequest = favoriteUseCase.getFavGames()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self else { return }
          self.loadingState = false
          if case .failure(let error) = completion {
            self.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] games in
          self?.favGames = games
        }
      )
  }

  private func observeFavoriteChanges() {
    favoritesChangeObserver = NotificationCenter.default.publisher(for: .favoritesDidChange)
      .receive(on: RunLoop.main)
      .sink { [weak self] _ in
        self?.shouldRefreshOnAppear = true
      }
  }

  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: LazyView(self.router.makeDetailView(for: game, onDismiss: { [weak self] change in
        self?.applyFavoriteChange(change)
      }))
    ) { content() }
  }

}
