//
//  ProfileInteractor.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import Foundation

protocol ProfileUseCase {
}

class ProfileInteractor: ProfileUseCase {

  private let repository: GamesRepositoryProtocol
  
  required init(repository: GamesRepositoryProtocol) {
    self.repository = repository
  }
}
