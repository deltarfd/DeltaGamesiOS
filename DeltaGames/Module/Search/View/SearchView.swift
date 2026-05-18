//
//  SearchView.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 01/10/21.
//

import SwiftUI

struct SearchView: View {
  @State private var searchText = ""
  @State private var isEditing = false
  @State private var searchWorkItem: DispatchWorkItem?
  @State private var hasInitialized = false
  @AppStorage("app_language") private var appLanguageCode: String = AppLanguage.system.rawValue
  @ObservedObject var presenter: SearchPresenter
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  var body: some View {
    AppNavigationContainer {
        ScrollView {
            VStack(alignment: .leading) {
            Label(L10n.text("search.title"), systemImage: "magnifyingglass.circle.fill")
                    .padding(.horizontal)
                    .font(Font.title2.weight(.bold))
                  .foregroundColor(.appPrimary)
                searchBarView
                   .padding()
              ZStack {
                if presenter.loadingState {
                  HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                  }
                } else if !presenter.errorMessage.isEmpty {
                  Text(presenter.errorMessage)
                } else if presenter.searchGames.isEmpty
                          && !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                          && searchText.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 {
                  HStack {
                      Spacer()
                    Text(L10n.text("search.not_found"))
                          .padding(.top, 64)
                      Spacer()
                  }
                } else if !presenter.searchGames.isEmpty {
                  searchGameView
                }
              }
            }
        }
        .onDisappear {
            searchWorkItem?.cancel()
          isEditing = false
        }
        .onAppear {
            guard !hasInitialized else { return }
            hasInitialized = true
            DispatchQueue.main.async {
              if presenter.searchGames.isEmpty {
                presenter.loadInitialGames()
              }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
  }
}
extension SearchView {
    var searchBarView: some View {
        HStack {
          TextField(
            L10n.text("search.placeholder"),
            text: $searchText,
            onEditingChanged: { editing in
              isEditing = editing
            }
          )
                .onChange(of: searchText, perform: { _ in
                  searchWorkItem?.cancel()

                  let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                  if trimmed.count == 1 {
                    presenter.resetSearch()
                    return
                  }

                  let workItem = DispatchWorkItem {
                    presenter.getSearchGames(search: searchText)
                  }
                  searchWorkItem = workItem
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: workItem)
                })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing || !searchText.isEmpty {
                            Button {
                              searchText = ""
                            presenter.getSearchGames(search: "")
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
            
              if isEditing || !searchText.isEmpty {
                Button {
                  isEditing = false
                  searchWorkItem?.cancel()
                    searchText = ""
                  presenter.getSearchGames(search: "")
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                  Text(L10n.text("common.cancel"))
                }
                .padding(.trailing, 10)
            }
        }
    }
}
extension SearchView {
    var searchGameView: some View {
        LazyVGrid(columns: columns, alignment: .center) {
          ForEach(self.presenter.searchGames) { game in
            self.presenter.linkBuilder(for: game, destination: { linkedGame in
                AnyView(LazyView(SearchRouter().makeDetailView(for: linkedGame)))
          }, content: {
                    GameCardView(game: game)
                        .padding()
                        .frame(height: UIScreen.main.bounds.height/3)
              }).buttonStyle(PlainButtonStyle())
            }
        }
    }
}
