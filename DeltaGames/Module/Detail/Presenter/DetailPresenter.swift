//
//  DetailPresenter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI
import Combine

struct FavoriteChange {
  let game: GameModel
  let isFavorite: Bool
}

@MainActor
final class DetailPresenter: ObservableObject {
  private static let favoritesDidChangeNotification = Notification.Name("favoritesDidChange")
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  private let id: String
  private var hasLoaded = false
  private var favoriteChange: FavoriteChange?
  
  @Published var game = GameModel()
  @Published var isFav: Bool = false
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(id: String, detailUseCase: DetailUseCase) {
    self.id = id
    self.detailUseCase = detailUseCase
  }

  var pendingFavoriteChange: FavoriteChange? {
    favoriteChange
  }

  func loadIfNeeded() {
    guard !hasLoaded else { return }
    hasLoaded = true
    getDetailGame(from: id)
    isFavGame(from: id)
  }
  
  func getDetailGame(from id: String) {
    errorMessage = ""
    loadingState = true
    detailUseCase.getDetailGame(from: id)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self else { return }
          self.loadingState = false
          if case .failure(let error) = completion {
            self.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] game in
          self?.game = game
        }
      )
        .store(in: &cancellables)
  }
  
  func isFavGame(from id: String) {
    detailUseCase.isFavGame(from: id)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          if case .failure(let error) = completion {
            self?.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] isFavGame in
          self?.isFav = isFavGame
        }
      )
        .store(in: &cancellables)
  }
  
  func addFavGame(from id: GameModel) {
    errorMessage = ""
    detailUseCase.addFavGame(from: id)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          if case .failure(let error) = completion {
            self?.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] isFavGame in
          self?.isFav = isFavGame
          guard let self, isFavGame else { return }
          self.favoriteChange = FavoriteChange(game: self.game, isFavorite: true)
          NotificationCenter.default.post(name: Self.favoritesDidChangeNotification, object: nil)
        }
      )
        .store(in: &cancellables)
  }
  
  func delFavGame(from id: String) {
    errorMessage = ""
    detailUseCase.delFavGame(from: id)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          if case .failure(let error) = completion {
            self?.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] _ in
          guard let self else { return }
          self.isFav = false
          self.favoriteChange = FavoriteChange(game: self.game, isFavorite: false)
          NotificationCenter.default.post(name: Self.favoritesDidChangeNotification, object: nil)
        }
      )
        .store(in: &cancellables)
  }

}
