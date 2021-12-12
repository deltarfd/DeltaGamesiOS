//
//  TrendingEntity.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 16/11/21.
//

import Foundation
import RealmSwift

class TrendingEntity: Object {

  @Persisted dynamic var id: Int = 0
  @Persisted dynamic var slug: String = ""
  @Persisted dynamic var name: String = ""
  @Persisted dynamic var descript: String = ""
  @Persisted dynamic var released: String? = ""
  @Persisted dynamic var backgroundImage: String? = ""
  @Persisted dynamic var rating: Double = 0
  @Persisted dynamic var ratingTop: Int = 0
  @Persisted dynamic var ratingsCount: Int = 0
  @Persisted dynamic var genres = List<GenreEntity>()
  @Persisted dynamic var parentPlatforms = List<PlatformEntity>()
  @Persisted dynamic var tags = List<TagsEntity>()

  override static func primaryKey() -> String? {
    return "id"
  }
}
