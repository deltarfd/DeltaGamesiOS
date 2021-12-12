//
//  ProfileInteractor.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import Foundation

protocol ProfileUseCase {

//  func getGames(completion: @escaping (Result<[GameModel], Error>) -> Void)

}

class ProfileInteractor: ProfileUseCase {

  private let repository: GamesRepositoryProtocol
  
  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
  
//  func getGames(
//    completion: @escaping (Result<[GameModel], Error>) -> Void
//  ) {
//    repository.getGames { result in
//      completion(result)
//    }
//  }

}
