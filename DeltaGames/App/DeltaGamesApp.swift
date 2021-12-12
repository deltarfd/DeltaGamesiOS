//
//  DeltaGamesApp.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

@main
struct DeltaGamesApp: App {
    var body: some Scene {
      let homeUseCase = Injection.init().provideHome()
      let searchUseCase = Injection.init().provideSearch()
      let favoriteUseCase = Injection.init().provideFavorite()
      let profileUseCase = Injection.init().provideProfile()
      
      let homePresenter = HomePresenter(homeUseCase: homeUseCase)
      let searchPresenter = SearchPresenter(searchUseCase: searchUseCase)
      let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
      let profilePresenter = ProfilePresenter(profileUseCase: profileUseCase)
      
      WindowGroup {
        MainView()
          .environmentObject(homePresenter)
          .environmentObject(searchPresenter)
          .environmentObject(favoritePresenter)
          .environmentObject(profilePresenter)
      }
      
    }
}
