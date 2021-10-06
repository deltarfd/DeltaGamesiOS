//
//  ContentView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct MainView: View {

    @ObservedObject private var homeViewModel = HomeViewModel(apiService: APIService())
    @ObservedObject private var searchViewModel = SearchViewModel(apiService: APIService())
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView(homeViewModel: homeViewModel)
                .tabItem {
                    if selection == 0 {
                        Label("Home", systemImage: "house.circle.fill")
                    } else {
                        Label("Home", systemImage: "house.circle")
                    }
                }.tag(0)

            SearchView(searchViewModel: searchViewModel)
                .tabItem {
                    if selection == 1 {
                        Label("Search", systemImage: "magnifyingglass.circle.fill")
                    } else {
                        Label("Search", systemImage: "magnifyingglass.circle")
                    }
                }.tag(1)
            ProfileView()
                .tabItem {
                    if selection == 2 {
                        Label("Profile", systemImage: "person.crop.circle.fill")
                    } else {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                }.tag(2)
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
