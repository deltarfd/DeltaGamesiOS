//
//  ProfilePresenter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI

class ProfilePresenter: ObservableObject {

  private let profileUseCase: ProfileUseCase
  
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  init(profileUseCase: ProfileUseCase) {
    self.profileUseCase = profileUseCase
  }

}
