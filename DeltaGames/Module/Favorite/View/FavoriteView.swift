//
//  FavoriteView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 06/10/21.
//

import SwiftUI

struct FavoriteView: View {
  @AppStorage("app_language") private var appLanguageCode: String = AppLanguage.system.rawValue
    @ObservedObject var presenter: FavoritePresenter
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
    AppNavigationContainer {
          ScrollView {
              VStack(alignment: .leading) {
                Label(L10n.text("favorite.title"), systemImage: "heart.circle.fill")
                    .padding(.horizontal)
                    .font(Font.title2.weight(.bold))
                  .foregroundColor(.appPrimary)
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
                              Text(L10n.text("favorite.empty"))
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
              }
          }
          .navigationBarHidden(true)
          .navigationBarTitle("", displayMode: .inline)
      }
      .onAppear {
        DispatchQueue.main.async {
          presenter.handleAppear()
        }
      }
    }
}
extension FavoriteView {
  var favGameView: some View {
    LazyVGrid(columns: columns, alignment: .center) {
      ForEach(presenter.favGames) { game in
      self.presenter.linkBuilder(for: game, destination: { linkedGame, onDismiss in
        AnyView(LazyView(FavoriteRouter().makeDetailView(for: linkedGame, onDismiss: onDismiss)))
      }) {
            GameCardView(game: game)
                .padding()
                .frame(height: UIScreen.main.bounds.height/3)
        }.buttonStyle(PlainButtonStyle())
      }
    }
  }
}
