//
//  PlatformEntity.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 09/11/21.
//

import Foundation
import RealmSwift

class PlatformEntity: Object {
  @Persisted dynamic var platform: ChildPlatformEntity = ChildPlatformEntity()
}

class ChildPlatformEntity: Object {
  @Persisted dynamic var id: Int = 0
  @Persisted dynamic var slug: String = ""
  @Persisted dynamic var name: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
