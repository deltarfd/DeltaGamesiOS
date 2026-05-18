//
//  HomePresenter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI
import Combine

@MainActor
final class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let homeUseCase: HomeUseCase
  private var hasLoaded = false
  
  @Published var trending: [GameModel] = []
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingTrending: Bool = false
  @Published var loadingGames: Bool = false
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }

  func loadIfNeeded() {
    guard !hasLoaded else { return }
    hasLoaded = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
      guard let self else { return }
      self.getTrending(ordering: "-relevance", discover: "true")
      self.getGames()
    }
  }
  
  func getGames() {
    guard !loadingGames else { return }
    errorMessage = ""
    loadingGames = true
    homeUseCase.getGames()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self else { return }
          self.loadingGames = false
          if case .failure(let error) = completion {
            self.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] games in
          self?.games = games
        }
      )
        .store(in: &cancellables)
  }
  
  func getTrending(ordering: String, discover: String) {
    guard !loadingTrending else { return }
    errorMessage = ""
    loadingTrending = true
    homeUseCase.getTrending(ordering: ordering, discover: discover)
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { [weak self] completion in
          guard let self else { return }
          self.loadingTrending = false
          if case .failure(let error) = completion {
            self.errorMessage = error.localizedDescription
          }
        },
        receiveValue: { [weak self] trending in
          self?.trending = trending
        }
      )
        .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for game: GameModel,
    destination: @escaping (GameModel) -> AnyView,
    @ViewBuilder detailView: () -> Content
  ) -> some View {
    return AnyView(NavigationLink(
      destination: destination(game)
    ) { detailView() }
    )
  }

}
