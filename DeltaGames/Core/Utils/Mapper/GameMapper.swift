//
//  GameMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/12/21.
//

import Foundation

final class GameMapper {

  static func mapGameResponsesToEntities(
    input gameResponses: GameResponse
  ) -> GameEntity {
      let newGame = GameEntity()
      newGame.id = gameResponses.id
      newGame.slug = gameResponses.slug
      newGame.name = gameResponses.name
      newGame.descript = gameResponses.description ?? ""
      newGame.released = gameResponses.released ?? ""
      newGame.backgroundImage = gameResponses.imageBackground ?? ""
      newGame.rating = gameResponses.rating ?? 0
      newGame.ratingTop = gameResponses.ratingTop ?? 0
      newGame.ratingsCount = gameResponses.ratingsCount ?? 0
      newGame.genres.append(objectsIn: GenreMapper.mapGenreResponsesToEntities(input: gameResponses.genres ?? []))
      newGame.parentPlatforms.append(objectsIn: PlatformMapper.mapPlatformResponsesToEntities(input: gameResponses.parentPlatforms ?? []))
      newGame.tags.append(objectsIn: TagsMapper.mapTagsResponsesToEntities(input: gameResponses.tags ?? []))
      
      return newGame
    }

  static func mapGameEntitiesToDomains(
    input gameEntities: GameEntity
  ) -> GameModel {
      return GameModel(
        id: gameEntities.id,
        slug: gameEntities.slug,
        name: gameEntities.name,
        description: gameEntities.descript,
        released: gameEntities.released,
        imageBackground: gameEntities.backgroundImage,
        rating: gameEntities.rating,
        ratingTop: gameEntities.ratingTop,
        ratingsCount: gameEntities.ratingsCount,
        genres: GenreMapper.mapGenreEntitiesToDomains(input: Array(gameEntities.genres)),
        parentPlatforms: PlatformMapper.mapPlatformEntitiesToDomains(input: Array(gameEntities.parentPlatforms)),
        tags: TagsMapper.mapTagsEntitiesToDomains(input: Array(gameEntities.tags))
      )
  }
  
  static func mapGameDomainsToEntities(
    input gameDomains: GameModel
  ) -> GameEntity {
    let newGame = GameEntity()
    newGame.id = gameDomains.id
    newGame.slug = gameDomains.slug
    newGame.name = gameDomains.name
    newGame.descript = gameDomains.description ?? ""
    newGame.released = gameDomains.released ?? ""
    newGame.backgroundImage = gameDomains.imageBackground ?? ""
    newGame.rating = gameDomains.rating ?? 0
    newGame.ratingTop = gameDomains.ratingTop ?? 0
    newGame.ratingsCount = gameDomains.ratingsCount ?? 0
    newGame.genres.append(objectsIn: GenreMapper.mapGenreDomainsToEntities(input: gameDomains.genres ?? []))
    newGame.parentPlatforms.append(objectsIn: PlatformMapper.mapPlatformDomainsToEntities(input: gameDomains.parentPlatforms ?? []))
    newGame.tags.append(objectsIn: TagsMapper.mapTagsDomainsToEntities(input: gameDomains.tags ?? []))
    return newGame
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
