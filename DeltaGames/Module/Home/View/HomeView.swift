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
    @ObservedObject var presenter: HomePresenter
 
    var body: some View {
      ZStack {
        if presenter.loadingState {
          ProgressView()
        } else if presenter.errorMessage != "" {
          gameView
        } else {
          Text(presenter.errorMessage)
        }
      }
      .onAppear {
        if self.presenter.games.count == 0 {
          self.presenter.getGames()
        }
        if self.presenter.trending.count == 0 {
          self.presenter.getTrending(ordering: "-relevance", discover: "true")
        }
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
                          ForEach(self.presenter.trending, id: \.id) { trending in
                            ZStack {
                              self.presenter.linkBuilder(for: trending) {
                                GameCardView(game: trending)
                                    .padding()
                                    .frame(width: UIScreen.main.bounds.width)
                              }.buttonStyle(PlainButtonStyle())
                            }.padding(8)
                          }
                        }
                    }.frame(height: UIScreen.main.bounds.height/3)
                    Label("Explore Games", systemImage: "gamecontroller")
                        .padding(.horizontal)
                        .font(Font.title2.weight(.bold))
                        .foregroundColor(Color("PrimaryColor"))
                    LazyVGrid(columns: columns, alignment: .center) {
                      ForEach(self.presenter.games) { game in
                        ZStack {
                          self.presenter.linkBuilder(for: game) {
                            GameCardView(game: game)
                                .padding()
                                .frame(height: UIScreen.main.bounds.height/3)
                          }.buttonStyle(PlainButtonStyle())
                        }.padding(8)
                        }
                    }
                }.padding(.vertical)
            }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}
