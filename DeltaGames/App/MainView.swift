//
//  ContentView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct MainView: View {

  @State var selection = 0
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var searchPresenter: SearchPresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  @EnvironmentObject var profilePresenter: ProfilePresenter
  
    var body: some View {
        TabView(selection: $selection) {
            HomeView(presenter: homePresenter)
                .tabItem {
                    if selection == 0 {
                        Label("Home", systemImage: "house.circle.fill")
                    } else {
                        Label("Home", systemImage: "house.circle")
                    }
                }.tag(0)

          SearchView(presenter: searchPresenter)
                .tabItem {
                    if selection == 1 {
                        Label("Search", systemImage: "magnifyingglass.circle.fill")
                    } else {
                        Label("Search", systemImage: "magnifyingglass.circle")
                    }
                }.tag(1)
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    if selection == 2 {
                        Label("Favorite", systemImage: "heart.circle.fill")
                    } else {
                        Label("Favorite", systemImage: "heart.circle")
                    }
                }.tag(2)
            ProfileView()
                .tabItem {
                    if selection == 3 {
                        Label("Profile", systemImage: "person.crop.circle.fill")
                    } else {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                }.tag(3)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice("iPhone 12 Pro Max")
            .preferredColorScheme(.dark)
        MainView()
            .previewDevice("iPhone 8")
            .preferredColorScheme(.dark)
    }
}
