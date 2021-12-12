//
//  GenreEntity.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 09/11/21.
//

import Foundation
import RealmSwift

class GenreEntity: Object {

  @Persisted dynamic var id: Int = 0
  @Persisted dynamic var slug: String = ""
  @Persisted dynamic var name: String = ""
  @Persisted dynamic var gamesCount: Int = 0
  @Persisted dynamic var imageBackground: String = ""

  override static func primaryKey() -> String? {
    return "id"
  }
}
