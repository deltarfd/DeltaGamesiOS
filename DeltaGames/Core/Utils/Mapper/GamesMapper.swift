//
//  GamesMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

final class GamesMapper {

  static func mapGamesResponsesToEntities(
    input gamesResponses: [GameResponse]
  ) -> [GameEntity] {
    return gamesResponses.map { result in
      let newGame = GameEntity()
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

  static func mapGamesEntitiesToDomains(
    input gamesEntities: [GameEntity]
  ) -> [GameModel] {
    return gamesEntities.map { result in
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

  static func mapGamesResponsesToDomains(
    input gamesResponses: [GameResponse]
  ) -> [GameModel] {
    return gamesResponses.map { result in
      return GameModel(
        id: result.id,
        slug: result.slug,
        name: result.name,
        description: result.description,
        released: result.released,
        imageBackground: result.imageBackground,
        rating: result.rating,
        ratingTop: result.ratingTop,
        ratingsCount: result.ratingsCount,
        genres: GenreMapper.mapGenreResponsesToDomains(input: result.genres ?? []),
        parentPlatforms: PlatformMapper.mapPlatformResponsesToDomains(input: result.parentPlatforms ?? []),
        tags: TagsMapper.mapTagsResponsesToDomains(input: result.tags ?? [])
      )
    }
  }
  
}
