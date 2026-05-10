//
//  FavoriteRouter.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import SwiftUI

@MainActor
final class FavoriteRouter {

  func makeDetailView(for game: GameModel, onDismiss: ((FavoriteChange?) -> Void)? = nil) -> some View {
    return Group {
      let detailUseCase = Injection.init().provideDetail(game: game)
      let presenter = DetailPresenter(id: "\(game.id)", detailUseCase: detailUseCase)
      DetailView(presenter: presenter, onDismiss: onDismiss)
    }
  }
  
}
