//
//  FavoriteView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 06/10/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
      ZStack {
        if presenter.loadingState {
          ProgressView()
        } else if presenter.errorMessage != "" {
          if presenter.favGames.isEmpty {
            HStack {
                Spacer()
                Text("No Favorite Game")
                    .padding(.top, 64)
                Spacer()
            }
          } else {
            favGameView
          }
        } else {
          Text(presenter.errorMessage)
        }
      }
      .onAppear {
        self.presenter.getFavGames()
      }
    }
}
extension FavoriteView {
  var favGameView: some View {
    NavigationView {
        ScrollView {
            VStack(alignment: .leading) {
              Label("Favorite Games", systemImage: "heart.circle.fill")
                  .padding(.horizontal)
                  .font(Font.title2.weight(.bold))
                  .foregroundColor(Color("PrimaryColor"))
              LazyVGrid(columns: columns, alignment: .center) {
                ForEach(presenter.favGames) { game in
                  self.presenter.linkBuilder(for: game) {
                      GameCardView(game: game)
                          .padding()
                          .frame(height: UIScreen.main.bounds.height/3)
                  }
                }
              }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
  }
}
