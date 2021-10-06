//
//  DetailViewModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 05/10/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    enum State {
        case loading
        case onSuccess
        case onFailed(String)
    }
    @Published private(set) var state: State = .loading
    @Published var detailGame: Game?
    private let apiService: APIService
    init(apiService: APIService) {
        self.apiService = apiService
    }
    func getDetailGame(id: Int) {
        self.state = .loading
        self.apiService.getDetailGame(gameID: id) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.state = .onSuccess
                    self.detailGame = response
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .onFailed(error.localizedDescription)
                }
            }
        }
    }
}
