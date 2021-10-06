//
//  HomeViewModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 03/10/21.
//

import Foundation

class HomeViewModel: ObservableObject {
    enum State {
        case loading
        case onSuccess
        case onFailed(String)
    }
    @Published private(set) var state: State = .loading
    @Published var trendingGames: [Game] = []
    @Published var allGames: [Game] = []
    private let apiService: APIService
    init(apiService: APIService) {
        self.apiService = apiService
    }
    func load() {
        state = .loading
        fetchGamesTrending()
        fetchGamesAll()
    }
    private func fetchGamesTrending() {
        self.apiService.getNewAndTrending(order: "-relevance", discover: "true") { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.state = .onSuccess
                    self.trendingGames = response.results
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .onFailed(error.localizedDescription)
                }
            }
        }
    }
    private func fetchGamesAll() {
        apiService.getListAllGame { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.state = .onSuccess
                    self.allGames = response.results
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .onFailed(error.localizedDescription)
                }
            }
        }
        
    }
    
}
