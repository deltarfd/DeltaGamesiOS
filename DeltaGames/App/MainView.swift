//
//  ContentView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct MainView: View {

    @State private var selection = 0
    @AppStorage("app_language") private var appLanguageCode: String = AppLanguage.system.rawValue
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var searchPresenter: SearchPresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  
    var body: some View {
        TabView(selection: $selection) {
            HomeView(presenter: homePresenter)
                .tabItem {
                    if selection == 0 {
                        Label(L10n.text("tab.home"), systemImage: "house.circle.fill")
                    } else {
                        Label(L10n.text("tab.home"), systemImage: "house.circle")
                    }
                }.tag(0)

          SearchView(presenter: searchPresenter)
                .tabItem {
                    if selection == 1 {
                        Label(L10n.text("tab.search"), systemImage: "magnifyingglass.circle.fill")
                    } else {
                        Label(L10n.text("tab.search"), systemImage: "magnifyingglass.circle")
                    }
                }.tag(1)
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    if selection == 2 {
                        Label(L10n.text("tab.favorite"), systemImage: "heart.circle.fill")
                    } else {
                        Label(L10n.text("tab.favorite"), systemImage: "heart.circle")
                    }
                }.tag(2)
            ProfileView()
                .tabItem {
                    if selection == 3 {
                        Label(L10n.text("tab.profile"), systemImage: "person.crop.circle.fill")
                    } else {
                        Label(L10n.text("tab.profile"), systemImage: "person.crop.circle")
                    }
                }.tag(3)
        }
    }
}
