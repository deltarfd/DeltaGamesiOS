//
//  SearchInteractor.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 04/11/21.
//

import Foundation
import Combine

protocol SearchUseCase {

  func getSearchGames(search: String) -> AnyPublisher<[GameModel], Error>

}

class SearchInteractor: SearchUseCase {

  private let repository: GamesRepositoryProtocol
  
  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
  
  func getSearchGames(search: String) -> AnyPublisher<[GameModel], Error> {
    repository.getSearchGames(search: search)
  }

}
