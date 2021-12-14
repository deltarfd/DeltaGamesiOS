//
//  GameMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/12/21.
//

import Foundation

final class GameMapper {
  
  static func mapGameDomainsToEntities(
    input gameModel: GameModel
  ) -> GameEntity {
    let gameEntity = GameEntity()
    gameEntity.id = gameModel.id
    gameEntity.slug = gameModel.slug
    gameEntity.name = gameModel.name
    gameEntity.descript = gameModel.description ?? ""
    gameEntity.released = gameModel.released ?? ""
    gameEntity.backgroundImage = gameModel.imageBackground ?? ""
    gameEntity.rating = gameModel.rating ?? 0
    gameEntity.ratingTop = gameModel.ratingTop ?? 0
    gameEntity.ratingsCount = gameModel.ratingsCount ?? 0
    for platform in gameModel.parentPlatforms! {
      gameEntity.parentPlatforms.append(platform.platform.name)
    }
    for genre in gameModel.genres! {
        gameEntity.genres.append(genre.name)
    }
    for tag in gameModel.tags! {
        gameEntity.genres.append(tag.name)
    }
    return gameEntity
  }
  
  static func mapGameResponsesToDomains(
    input gameResponses: GameResponse
  ) -> GameModel {
      return GameModel(
        id: gameResponses.id,
        slug: gameResponses.slug,
        name: gameResponses.name,
        description: gameResponses.description,
        released: gameResponses.released,
        imageBackground: gameResponses.imageBackground,
        rating: gameResponses.rating,
        ratingTop: gameResponses.ratingTop,
        ratingsCount: gameResponses.ratingsCount,
        genres: GenreMapper.mapGenreResponsesToDomains(input: gameResponses.genres ?? []),
        parentPlatforms: PlatformMapper.mapPlatformResponsesToDomains(input: gameResponses.parentPlatforms ?? []),
        tags: TagsMapper.mapTagsResponsesToDomains(input: gameResponses.tags ?? [])
      )
  }
}
