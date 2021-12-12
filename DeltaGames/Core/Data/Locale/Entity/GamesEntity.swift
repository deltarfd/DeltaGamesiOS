//
//  GamesEntity.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 15/11/21.
//

import Foundation
import RealmSwift

class ResultsEntity: Object {
  @Persisted dynamic var games: List<GameEntity>
}

class TredingGamesEntity: Object {
  @Persisted dynamic var games: List<GameEntity>
}

class SearchGamesEntity: Object {
  @Persisted dynamic var games: List<GameEntity>
}
