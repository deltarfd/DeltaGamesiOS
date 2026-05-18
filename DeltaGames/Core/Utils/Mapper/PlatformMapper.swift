//
//  PlatformMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

final class PlatformMapper {

  static func mapPlatformResponsesToDomains(
    input platformResponses: [PlatformResponse]
  ) -> [PlatformModel] {
    return platformResponses.map { result in
      return PlatformModel(
        platform: PlatformModel.ChildPlatformModel(
          name: result.platform.name
        )
      )
    }
  }

}
