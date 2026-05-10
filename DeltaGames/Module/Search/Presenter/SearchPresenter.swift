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
  private let router = SearchRouter()
  private let searchUseCase: SearchUseCase

  @Published var searchGames: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(searchUseCase: SearchUseCase) {
    self.searchUseCase = searchUseCase
  }

  func resetSearch() {
    errorMessage = ""
    loadingState = false
    searchGames = []
  }
  
  func loadInitialGames() {
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
        }
      )
        .store(in: &cancellables)
  }
  
  func getSearchGames(search: String) {
    let query = search.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !query.isEmpty else {
      loadInitialGames()
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
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: LazyView(self.router.makeDetailView(for: game))
    ) { content() }
  }

}
