//
//  SearchViewModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 05/10/21.
//

import Foundation

class SearchViewModel: ObservableObject {
    enum State {
        case loading
        case onSuccess
        case onFailed(String)
    }
    @Published private(set) var state: State = .loading
    @Published var searchGames: [Game] = []
    @Published var searchQuery: String = ""
    
    private let apiService: APIService
    init(apiService: APIService) {
        self.apiService = apiService
    }
    func fetchSearchGames(search: String) {
        self.state = .loading
        self.apiService.getSearchGame(search: searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.state = .onSuccess
                    self.searchGames = response.results
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .onFailed(error.localizedDescription)
                }
            }
        }
    }
}
