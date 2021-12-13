//
//  HomePresenter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  
  @Published var trending: [GameModel] = []
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingTrending: Bool = false
  @Published var loadingGames: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getGames() {
    loadingGames = true
    homeUseCase.getGames()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingGames = false
          }
        }, receiveValue: { games in
          self.games = games
        })
        .store(in: &cancellables)
  }
  
  func getTrending(ordering: String, discover: String) {
    loadingTrending = true
    homeUseCase.getTrending(ordering: ordering, discover: discover)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.loadingTrending = false
          }
        }, receiveValue: { trending in
          self.trending = trending
        })
        .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder detailView: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: game)) { detailView() }
  }

}
