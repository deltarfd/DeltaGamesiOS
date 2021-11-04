//
//  DetailViewModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 05/10/21.
//

import Foundation
import CoreData

class DetailViewModel: ObservableObject {
    enum State {
        case loading
        case onSuccess
        case onFailed(String)
    }
    private let CDM = CoreDataManager.shared.context
    @Published private(set) var state: State = .loading
    @Published var detailGame: Game?
    @Published var isFavorite = false
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
    func gameFavorite(id: Int) {
        var results    = [GameCD]()
        let request: NSFetchRequest<GameCD>    = GameCD.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(id)")
        do {
            results = try self.CDM.fetch(request)
            if results.count > 0 {
                isFavorite = true
            }
        } catch let error as NSError {
            print(error)
        }
    }
    func fetchGame(id: Int) -> GameCD? {
        var results    = [GameCD]()
        let request: NSFetchRequest<GameCD> = GameCD.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(id)")
        do {
            results = try self.CDM.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return results.first
    }
    func deleteGame(id: Int) {
        do {
            if let game = fetchGame(id: id) {
                self.CDM.delete(game)
                try self.CDM.save()
                isFavorite = false
            }
        } catch let error as NSError {
            print(error)
        }
    }
    func favoritedGame(id: Int, name: String, backgroundImage: String, rating: Double, released: String, genres: String) {
        let favGame      = GameCD(context: CDM)
        favGame.id       = Int64(id)
        favGame.name     = name
        favGame.rating   = rating
        favGame.backgroundImage = backgroundImage
        favGame.released = released
        favGame.genres = genres
        do {
            try self.CDM.save()
            isFavorite = true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
