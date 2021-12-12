//
//  PlatformMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

final class PlatformMapper {

  static func mapPlatformResponsesToEntities(
    input platformResponses: [PlatformResponse]
  ) -> [PlatformEntity] {
    return platformResponses.map { result in
      let newPlatform = PlatformEntity()
      newPlatform.platform.id = result.platform.id
      newPlatform.platform.name = result.platform.name
      newPlatform.platform.slug = result.platform.slug
      return newPlatform
    }
  }
  
  static func mapPlatformDomainsToEntities(
    input platformDomains: [PlatformModel]
  ) -> [PlatformEntity] {
    return platformDomains.map { result in
      let newPlatform = PlatformEntity()
      newPlatform.platform.id = result.platform.id
      newPlatform.platform.name = result.platform.name
      newPlatform.platform.slug = result.platform.slug
      return newPlatform
    }
  }

  static func mapPlatformEntitiesToDomains(
    input platformEntities: [PlatformEntity]
  ) -> [PlatformModel] {
    return platformEntities.map { result in
      return PlatformModel(
        platform: PlatformModel.ChildPlatformModel(
          id: result.platform.id, slug: result.platform.slug, name: result.platform.name
        )
      )
    }
  }

  static func mapPlatformResponsesToDomains(
    input platformResponses: [PlatformResponse]
  ) -> [PlatformModel] {
    return platformResponses.map { result in
      return PlatformModel(
        platform: PlatformModel.ChildPlatformModel(
          id: result.platform.id, slug: result.platform.slug, name: result.platform.name
        )
      )
    }
  }
  
}
