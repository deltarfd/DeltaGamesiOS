//
//  FavoriteView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 06/10/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favoriteViewModel: FavoriteViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Label("Favorite Games", systemImage: "heart.circle.fill")
                        .padding(.horizontal)
                        .font(Font.title2.weight(.bold))
                        .foregroundColor(Color("PrimaryColor"))
                    switch favoriteViewModel.state {
                    case .loading:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .onAppear {
                            favoriteViewModel.getAllFavorites()
                        }
                    case .onSuccess:
                        if favoriteViewModel.favGames.isEmpty {
                            HStack {
                                Spacer()
                                Text("No Favorite Game")
                                    .padding(.top, 64)
                                Spacer()
                            }
                        } else {
                            favGameView
                        }
                    case .onFailed(let message):
                        Text(message)
                    }
                }
            }
            .onAppear(perform: {
                favoriteViewModel.getAllFavorites()
            })
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}
extension FavoriteView {
  var favGameView: some View {
        LazyVGrid(columns: columns, alignment: .center) {
            ForEach(favoriteViewModel.favGames) { game in
                NavigationLink(destination: GameDetailView(detailViewModel: DetailViewModel(apiService: APIService()), id: game.id)) {
                    GameCardView(game: game)
                        .padding()
                        .frame(height: UIScreen.main.bounds.height/3)
                }
            }
        }
    }
}
