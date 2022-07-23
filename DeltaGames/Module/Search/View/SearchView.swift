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
  @ObservedObject var presenter: SearchPresenter
  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  var body: some View {
    NavigationView {
        ScrollView {
            VStack(alignment: .leading) {
                Label("Search Games", systemImage: "magnifyingglass.circle.fill")
                    .padding(.horizontal)
                    .font(Font.title2.weight(.bold))
                    .foregroundColor(Color("PrimaryColor"))
                searchBarView
                   .padding()
              ZStack {
                if presenter.loadingState {
                  HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                  }
                } else if presenter.errorMessage != "" {
                  if presenter.searchGames.isEmpty {
                      HStack {
                          Spacer()
                          Text("Game is Not Found")
                              .padding(.top, 64)
                          Spacer()
                      }
                  } else {
                      searchGameView
                  }
                } else {
                  Text(presenter.errorMessage)
                }
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
          TextField("Search ...", text: $searchText)
                .onChange(of: searchText, perform: { _ in
                  presenter.getSearchGames(search: searchText)
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
                        if isEditing {
                            Button {
                              searchText = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button {
                    self.isEditing = false
                    searchText = ""
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
extension SearchView {
    var searchGameView: some View {
        LazyVGrid(columns: columns, alignment: .center) {
          ForEach(self.presenter.searchGames) { game in
            self.presenter.linkBuilder(for: game) {
                    GameCardView(game: game)
                        .padding()
                        .frame(height: UIScreen.main.bounds.height/3)
                }
            }
        }
    }
}
