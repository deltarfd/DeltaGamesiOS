//
//  HomeView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct HomeView: View {
    let rows = [GridItem(.flexible())]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var homeViewModel: HomeViewModel
 
    var body: some View {
        switch homeViewModel.state {
        case .loading:
            ProgressView()
                .onAppear {
                    homeViewModel.load()
                }
        case .onSuccess:
            gameView
        case .onFailed(let message):
            Text(message)
        }
    }
    
}
extension HomeView {
    var gameView: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Hey")
                                    .font(.title3)
                                Text("Delta R F D 👋🏻")
                                    .bold()
                                    .font(.title3)
                            }
                            Text("Let's Explore The Games!")
                                .font(.title3)
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        Spacer()
                        Image("deltarfd")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(maxHeight: 150, alignment: .trailing)

                    }.padding(.horizontal)
                    Label("New & Trending", systemImage: "flame")
                        .padding(.horizontal)
                        .font(Font.title2.weight(.bold))
                        .foregroundColor(Color("PrimaryColor"))
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, alignment: .center) {
                            ForEach(homeViewModel.trendingGames, id: \.id) { game in
                                NavigationLink(destination: GameDetailView(detailViewModel: DetailViewModel(apiService: APIService()), id: game.id)) {
                                    GameCardView(game: game)
                                        .padding()
                                        .frame(width: UIScreen.main.bounds.width)
                                }
                            }
                        }
                    }.frame(height: UIScreen.main.bounds.height/3)
                    Label("Explore Games", systemImage: "gamecontroller")
                        .padding(.horizontal)
                        .font(Font.title2.weight(.bold))
                        .foregroundColor(Color("PrimaryColor"))
                    LazyVGrid(columns: columns, alignment: .center) {
                        ForEach(homeViewModel.allGames) { game in
                            NavigationLink(destination: GameDetailView(detailViewModel: DetailViewModel(apiService: APIService()), id: game.id)) {
                                GameCardView(game: game)
                                    .padding()
                                    .frame(height: UIScreen.main.bounds.height/3)
                            }
                        }
                    }
                }.padding(.vertical)
            }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}
