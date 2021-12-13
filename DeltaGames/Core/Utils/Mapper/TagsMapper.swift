//
//  TagsMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

final class TagsMapper {

  static func mapTagsResponsesToDomains(
    input tagsResponses: [TagsResponse]
  ) -> [TagsModel] {
    return tagsResponses.map { result in
      return TagsModel(
        id: result.id,
        slug: result.slug,
        name: result.name,
        language: result.language,
        gamesCount: result.gamesCount,
        imageBackground: result.imageBackground
      )
    }
  }
  
}
