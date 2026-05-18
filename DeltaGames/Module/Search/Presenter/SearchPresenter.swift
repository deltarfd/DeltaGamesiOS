//
//  SearchPresenter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI
import Combine

@MainActor
final class SearchPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let searchUseCase: SearchUseCase
  private var initialGamesCache: [GameModel] = []
  private var didLoadInitialGames = false

  @Published var searchGames: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }

  func resetSearch() {
    errorMessage = ""
    loadingState = false
    if didLoadInitialGames {
      searchGames = initialGamesCache
    } else {
      searchGames = []
    }
  }
  
  func loadInitialGames() {
    if didLoadInitialGames {
      errorMessage = ""
      loadingState = false
      searchGames = initialGamesCache
      return
    }

    errorMessage = ""
    loadingState = true
    cancellables.removeAll()
    searchUseCase.getSearchGames(search: "")
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
          self?.searchGames = games
          self?.initialGamesCache = games
          self?.didLoadInitialGames = true
        }
      )
        .store(in: &cancellables)
  }
  
  func getSearchGames(search: String) {
    let query = search.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !query.isEmpty else {
      if didLoadInitialGames {
        errorMessage = ""
        loadingState = false
        searchGames = initialGamesCache
      } else {
        loadInitialGames()
      }
      return
    }

    guard query.count >= 2 else {
      errorMessage = ""
      loadingState = false
      searchGames = didLoadInitialGames ? initialGamesCache : []
      return
    }

    errorMessage = ""
    loadingState = true
    cancellables.removeAll()
    searchUseCase.getSearchGames(search: query)
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
          self?.searchGames = games
        }
      )
        .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(
    for game: GameModel,
    destination: @escaping (GameModel) -> AnyView,
    @ViewBuilder content: () -> Content
  ) -> some View {
    return AnyView(NavigationLink(
      destination: destination(game)
    ) { content() }
    )
  }

}
