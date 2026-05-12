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
    @State private var hasInitialized = false
  @AppStorage("app_language") private var appLanguageCode: String = AppLanguage.system.rawValue
    @ObservedObject var presenter: HomePresenter
 
    var body: some View {
      AppNavigationContainer {
          ScrollView {
              VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                          Text(L10n.text("home.greeting"))
                                .font(.title3)
                            Text("Delta R F D 👋🏻")
                                .bold()
                                .font(.title3)
                        }
                        Text(L10n.text("home.subtitle"))
                            .font(.title3)
                          .foregroundColor(.appPrimary)
                    }
                    Spacer()
                    Image(String.Asset.deltaRfd.rawValue)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(maxHeight: 150, alignment: .trailing)

                }.padding(.horizontal)
                Label(L10n.text("home.new_trending"), systemImage: "flame")
                    .padding(.horizontal)
                    .font(Font.title2.weight(.bold))
                  .foregroundColor(.appPrimary)
                ZStack {
                  VStack {
                    Spacer()
                    HStack(alignment: .center) {
                      Spacer()
                      if self.presenter.loadingTrending {
                        ProgressView()
                      } else if presenter.errorMessage != "" {
                        Text(presenter.errorMessage)
                      } else {
                        trendingGamesView
                      }
                      Spacer()
                    }
                    Spacer()
                  }
                }
                Label(L10n.text("home.explore_games"), systemImage: "gamecontroller")
                    .padding(.horizontal)
                    .font(Font.title2.weight(.bold))
                  .foregroundColor(.appPrimary)
                ZStack {
                  VStack {
                    Spacer()
                    HStack(alignment: .center) {
                      Spacer()
                      if self.presenter.loadingGames {
                        ProgressView()
                      } else if presenter.errorMessage != "" {
                        Text(presenter.errorMessage)
                      } else {
                        allGamesView
                      }
                      Spacer()
                    }
                    Spacer()
                  }
                }
              }.padding(.vertical)
          }
          .onAppear {
            guard !hasInitialized else { return }
            hasInitialized = true
            DispatchQueue.main.async {
              presenter.loadIfNeeded()
            }
          }
          .navigationBarHidden(true)
          .navigationBarTitle("", displayMode: .inline)
      }
    }
}
extension HomeView {
  var trendingGamesView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
        LazyHGrid(rows: rows, alignment: .center) {
          ForEach(self.presenter.trending, id: \.id) { trending in
            self.presenter.linkBuilder(for: trending) {
              GameCardView(game: trending)
                  .padding()
                  .frame(width: UIScreen.main.bounds.width)
            }.buttonStyle(PlainButtonStyle())
          }
        }
    }.frame(height: UIScreen.main.bounds.height/3)
  }
  
  var allGamesView: some View {
    LazyVGrid(columns: columns, alignment: .center) {
      ForEach(self.presenter.games) { game in
        self.presenter.linkBuilder(for: game) {
          GameCardView(game: game)
              .padding()
              .frame(height: UIScreen.main.bounds.height/3)
        }.buttonStyle(PlainButtonStyle())
        }
    }
  }
}
