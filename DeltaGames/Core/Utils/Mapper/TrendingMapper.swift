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
      let gameEntity = TrendingEntity()
      gameEntity.id = result.id
      gameEntity.slug = result.slug
      gameEntity.name = result.name
      gameEntity.descript = result.description ?? ""
      gameEntity.released = result.released ?? ""
      gameEntity.backgroundImage = result.imageBackground ?? ""
      gameEntity.rating = result.rating ?? 0
      gameEntity.ratingTop = result.ratingTop ?? 0
      gameEntity.ratingsCount = result.ratingsCount ?? 0
      for platform in result.parentPlatforms! {
        gameEntity.parentPlatforms.append(platform.platform.name)
      }
      for genre in result.genres! {
          gameEntity.genres.append(genre.name)
      }
      for tag in result.tags! {
          gameEntity.genres.append(tag.name)
      }
      return gameEntity
    }
  }
  
  static func mapTrendingEntitiesToDomains(
    input gamesEntities: [TrendingEntity]
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
        genres: result.genres.map { result in
          return GenreModel(name: result)
        },
        parentPlatforms: result.parentPlatforms.map { result in
          return PlatformModel(platform: PlatformModel.ChildPlatformModel(name: result))
        },
        tags: result.tags.map { result in
          return TagsModel(name: result)
        }
      )
    }
  }
}
