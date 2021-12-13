//
//  GameMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/12/21.
//

import Foundation

final class GameMapper {

//  static func mapGameResponsesToEntities(
//    input gameResponses: GameResponse
//  ) -> GameEntity {
//      let newGame = GameEntity()
//      newGame.id = gameResponses.id
//      newGame.slug = gameResponses.slug
//      newGame.name = gameResponses.name
//      newGame.descript = gameResponses.description ?? ""
//      newGame.released = gameResponses.released ?? ""
//      newGame.backgroundImage = gameResponses.imageBackground ?? ""
//      newGame.rating = gameResponses.rating ?? 0
//      newGame.ratingTop = gameResponses.ratingTop ?? 0
//      newGame.ratingsCount = gameResponses.ratingsCount ?? 0
//      newGame.genres.append(objectsIn: GenreMapper.mapGenreResponsesToEntities(input: gameResponses.genres ?? []))
//      newGame.parentPlatforms.append(objectsIn: PlatformMapper.mapPlatformResponsesToEntities(input: gameResponses.parentPlatforms ?? []))
//      newGame.tags.append(objectsIn: TagsMapper.mapTagsResponsesToEntities(input: gameResponses.tags ?? []))
//
//      return newGame
//    }

//  static func mapGameEntitiesToDomains(
//    input gameEntities: GameEntity
//  ) -> GameModel {
//      return GameModel(
//        id: gameEntities.id,
//        slug: gameEntities.slug,
//        name: gameEntities.name,
//        description: gameEntities.descript,
//        released: gameEntities.released,
//        imageBackground: gameEntities.backgroundImage,
//        rating: gameEntities.rating,
//        ratingTop: gameEntities.ratingTop,
//        ratingsCount: gameEntities.ratingsCount,
//        genres: GenreMapper.mapGenreEntitiesToDomains(input: Array(gameEntities.genres)),
//        parentPlatforms: PlatformMapper.mapPlatformEntitiesToDomains(input: Array(gameEntities.parentPlatforms)),
//        tags: TagsMapper.mapTagsEntitiesToDomains(input: Array(gameEntities.tags))
//      )
//  }
  
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
