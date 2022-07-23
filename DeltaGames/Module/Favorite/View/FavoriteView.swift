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
      NavigationView {
          ScrollView {
              VStack(alignment: .leading) {
                Label("Favorite Games", systemImage: "heart.circle.fill")
                    .padding(.horizontal)
                    .font(Font.title2.weight(.bold))
                    .foregroundColor(Color("PrimaryColor"))
                ZStack {
                  VStack {
                    Spacer()
                    HStack(alignment: .center) {
                      Spacer()
                      if self.presenter.loadingState {
                        ProgressView()
                      } else if presenter.errorMessage != "" {
                        Text(presenter.errorMessage)
                      } else {
                        if presenter.favGames.isEmpty {
                          HStack {
                              Text("No Favorite Game")
                                  .padding(.top, 64)
                          }
                        } else {
                          favGameView
                        }
                      }
                      Spacer()
                    }
                    Spacer()
                  }
                }
                .onAppear {
                  self.presenter.getFavGames()
                }
              }
          }
          .navigationBarHidden(true)
          .navigationBarTitle("", displayMode: .inline)
      }
    }
}
extension FavoriteView {
  var favGameView: some View {
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
