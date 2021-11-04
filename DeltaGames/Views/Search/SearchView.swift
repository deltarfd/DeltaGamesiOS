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
    @ObservedObject var searchViewModel: SearchViewModel
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
                    switch searchViewModel.state {
                    case .loading:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        .onAppear {
                            searchViewModel.fetchSearchGames(search: searchViewModel.searchQuery)
                        }
                    case .onSuccess:
                        if searchViewModel.searchGames.isEmpty {
                            HStack {
                                Spacer()
                                Text("Game is Not Found")
                                    .padding(.top, 64)
                                Spacer()
                            }
                        } else {
                            searchGameView
                        }
                    case .onFailed(let message):
                        Text(message)
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
            TextField("Search ...", text: $searchViewModel.searchQuery)
                .onChange(of: searchViewModel.searchQuery, perform: { _ in
                    searchViewModel.fetchSearchGames(search: searchViewModel.searchQuery)
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
                                searchViewModel.searchQuery = ""
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
                    searchViewModel.searchQuery = ""
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
            ForEach(searchViewModel.searchGames) { game in
                NavigationLink(destination: GameDetailView(detailViewModel: DetailViewModel(apiService: APIService()), id: game.id)) {
                    GameCardView(game: game)
                        .padding()
                        .frame(height: UIScreen.main.bounds.height/3)
                }
            }
        }
    }
}
