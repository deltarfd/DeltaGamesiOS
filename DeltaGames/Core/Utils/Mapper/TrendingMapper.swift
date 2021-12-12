//
//  TrendingMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 11/12/21.
//

import Foundation

final class TrendingMapper {
  static func mapGamesResponsesToTrendingEntities(
    input gamesResponses: [GameResponse]
  ) -> [TrendingEntity] {
    return gamesResponses.map { result in
      let newGame = TrendingEntity()
      newGame.id = result.id
      newGame.slug = result.slug
      newGame.name = result.name
      newGame.descript = result.description ?? ""
      newGame.released = result.released ?? ""
      newGame.backgroundImage = result.imageBackground ?? ""
      newGame.rating = result.rating ?? 0
      newGame.ratingTop = result.ratingTop ?? 0
      newGame.ratingsCount = result.ratingsCount ?? 0
      newGame.genres.append(objectsIn: GenreMapper.mapGenreResponsesToEntities(input: result.genres ?? []))
      newGame.parentPlatforms.append(objectsIn: PlatformMapper.mapPlatformResponsesToEntities(input: result.parentPlatforms ?? []))
      newGame.tags.append(objectsIn: TagsMapper.mapTagsResponsesToEntities(input: result.tags ?? []))
      
      return newGame
    }
  }
  
  static func mapTrendingEntitiesToDomains(
    input trendingEntities: [TrendingEntity]
  ) -> [GameModel] {
    return trendingEntities.map { result in
      return GameModel(
        id: result.id,
        slug: result.slug,
        name: result.name,
        description: result.descript,
        released: result.released,
        imageBackground: result.backgroundImage,
        rating: result.rating,
        ratingTop: result.ratingTop,
        ratingsCount: result.ratingsCount,
        genres: GenreMapper.mapGenreEntitiesToDomains(input: Array(result.genres)),
        parentPlatforms: PlatformMapper.mapPlatformEntitiesToDomains(input: Array(result.parentPlatforms)),
        tags: TagsMapper.mapTagsEntitiesToDomains(input: Array(result.tags))
      )
    }
  }
}
