//
//  FavoriteViewModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 06/10/21.
//

import Foundation
import CoreData

class FavoriteViewModel: ObservableObject {
    enum State {
        case loading
        case onSuccess
        case onFailed(String)
    }
    private let CDM = CoreDataManager.shared.context
    @Published private(set) var state: State = .loading
    @Published var favGames: [Game] = []
    
    func getAllFavorites() {
        self.state = .loading
        var results   = [GameCD]()
        let fetchRequest: NSFetchRequest<GameCD>  = GameCD.fetchRequest()
        do {
            results  = try self.CDM.fetch(fetchRequest)
            var games: [Game] = []
            for result in results {
                let game = Game(id: result.value(forKeyPath: "id") as! Int,
                                slug: "",
                                name: result.value(forKeyPath: "name") as! String,
                                description: result.value(forKeyPath: "description") as? String,
                                released: result.value(forKeyPath: "released") as? String,
                                backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
                                rating: result.value(forKeyPath: "rating") as? Double,
                                ratingTop: 5,
                                ratingsCount: 0,
                                genres: [],
                                parentPlatforms: [],
                                tags: [])
                games.append(game)
            }
            self.favGames = games
            self.state = .onSuccess
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
