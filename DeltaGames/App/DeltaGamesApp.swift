//
//  DeltaGamesApp.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

@main
struct DeltaGamesApp: App {
  @StateObject var homePresenter = HomePresenter(homeUseCase: Injection.shared.provideHome())
  @StateObject var searchPresenter = SearchPresenter(searchUseCase: Injection.shared.provideSearch())
  @StateObject var favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.shared.provideFavorite())
  @StateObject var profilePresenter = ProfilePresenter(profileUseCase: Injection.shared.provideProfile())
  
    var body: some Scene {
      WindowGroup {
        MainView()
          .environmentObject(homePresenter)
          .environmentObject(searchPresenter)
          .environmentObject(favoritePresenter)
          .environmentObject(profilePresenter)
      }
      
    }
}
