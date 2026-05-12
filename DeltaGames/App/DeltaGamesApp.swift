//
//  DeltaGamesApp.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI
import HomeFeature
import DetailFeature
import FavoriteFeature
import SearchFeature
import ProfileFeature

@main
struct DeltaGamesApp: App {
  @StateObject var homePresenter = HomePresenter(homeUseCase: Injection.shared.provideHome())
  @StateObject var searchPresenter = SearchPresenter(searchUseCase: Injection.shared.provideSearch())
  @StateObject var favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.shared.provideFavorite())
  @AppStorage("app_language") private var appLanguageCode: String = AppLanguage.system.rawValue

  private var currentLocale: Locale {
    let selectedLanguage = AppLanguage(rawValue: appLanguageCode) ?? .system
    return Locale(identifier: selectedLanguage.localeIdentifier)
  }
  
    var body: some Scene {
      WindowGroup {
        MainView()
          .environmentObject(homePresenter)
          .environmentObject(searchPresenter)
          .environmentObject(favoritePresenter)
          .environment(\.locale, currentLocale)
      }
      
    }
}
