//
//  DetailInteractor.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 04/11/21.
//

import Foundation
import Combine

protocol DetailUseCase {

  func getDetailGame(from id: String) -> AnyPublisher<GameModel, Error>
  func addFavGame(from id: GameModel) -> AnyPublisher<Bool, Error>
  func delFavGame(from id: String) -> AnyPublisher<Bool, Error>
  func isFavGame(from id: String) -> AnyPublisher<Bool, Error>

}

class DetailInteractor: DetailUseCase {

  private let repository: GamesRepositoryProtocol

  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
  
  func getDetailGame(from id: String) -> AnyPublisher<GameModel, Error> {
    return repository.getDetailGame(from: id)
  }
  
  func addFavGame(from id: GameModel) -> AnyPublisher<Bool, Error> {
    return repository.addFavGame(from: id)
  }
  
  func delFavGame(from id: String) -> AnyPublisher<Bool, Error> {
    return repository.delFavGame(from: id)
  }
  
  func isFavGame(from id: String) -> AnyPublisher<Bool, Error> {
    return repository.isFavGame(from: id)
  }

}
