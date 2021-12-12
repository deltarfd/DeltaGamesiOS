//
//  DetailPresenter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase
  
  @Published var game = GameModel()
  @Published var isFav: Bool = false
  @Published var isDel: Bool = false
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
  }
  
  func getDetailGame(from id: String) {
    loadingState = true
    detailUseCase.getDetailGame(from: id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { game in
          self.game = game
        })
        .store(in: &cancellables)
  }
  
  func isFavGame(from id: String) {
    loadingState = true
    detailUseCase.isFavGame(from: id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { isFavGame in
          self.isFav = isFavGame
        })
        .store(in: &cancellables)
  }
  
  func addFavGame(from id: GameModel) {
    loadingState = true
    detailUseCase.addFavGame(from: id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { isFavGame in
          self.isFav = isFavGame
        })
        .store(in: &cancellables)
  }
  
  func delFavGame(from id: String) {
    loadingState = true
    detailUseCase.delFavGame(from: id)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingState = false
          }
        }, receiveValue: { isDel in
          self.isDel = isDel
        })
        .store(in: &cancellables)
  }

}
