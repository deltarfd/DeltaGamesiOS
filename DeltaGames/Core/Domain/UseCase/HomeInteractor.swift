//
//  HomeInteractor.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 04/11/21.
//

import Combine

protocol HomeUseCase {
  func getGames() -> AnyPublisher<[GameModel], Error>
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModel], Error>
}

final class HomeInteractor: HomeUseCase {

  private let repository: GamesRepositoryProtocol
  
  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGames() -> AnyPublisher<[GameModel], Error> {
    repository.getGames()
  }
  
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModel], Error> {
    repository.getTrending(ordering: ordering, discover: discover)
  }

}
