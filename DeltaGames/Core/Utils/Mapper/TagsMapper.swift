//
//  TagsMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

final class TagsMapper {

  static func mapTagsResponsesToEntities(
    input tagsResponses: [TagsResponse]
  ) -> [TagsEntity] {
    return tagsResponses.map { result in
      let newTags = TagsEntity()
      newTags.id = result.id
      newTags.name = result.name
      newTags.slug = result.slug
      newTags.language = result.language
      newTags.imageBackground = result.imageBackground
      newTags.gamesCount = result.gamesCount
      return newTags
    }
  }
  
  static func mapTagsDomainsToEntities(
    input tagsDomains: [TagsModel]
  ) -> [TagsEntity] {
    return tagsDomains.map { result in
      let newTags = TagsEntity()
      newTags.id = result.id
      newTags.name = result.name
      newTags.slug = result.slug
      newTags.language = result.language
      newTags.imageBackground = result.imageBackground
      newTags.gamesCount = result.gamesCount
      return newTags
    }
  }

  static func mapTagsEntitiesToDomains(
    input tagsEntities: [TagsEntity]
  ) -> [TagsModel] {
    return tagsEntities.map { result in
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
