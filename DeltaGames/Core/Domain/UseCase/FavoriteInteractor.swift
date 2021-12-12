//
//  FavoriteInteractor.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 04/11/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {

  func getFavGames() -> AnyPublisher<[GameModel], Error>

}

class FavoriteInteractor: FavoriteUseCase {

  private let repository: GamesRepositoryProtocol
  
  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFavGames() -> AnyPublisher<[GameModel], Error> {
    return repository.getFavGames()
  }

}
