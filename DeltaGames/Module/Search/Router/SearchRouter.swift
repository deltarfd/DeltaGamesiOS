//
//  SearchRouter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI

class SearchRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(game: game)
    let presenter = DetailPresenter(id: "\(game.id)", detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
}
