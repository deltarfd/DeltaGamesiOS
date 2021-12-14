//
//  FavoriteMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 14/12/21.
//

import Foundation

final class FavoriteMapper {
  static func mapFavoriteEntitiesToDomains(
    input gamesEntities: [FavoriteEntity]
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
  
  static func mapGameDomainsToEntities(
    input gameModel: GameModel
  ) -> FavoriteEntity {
    let favEntity = FavoriteEntity()
    favEntity.id = gameModel.id
    favEntity.slug = gameModel.slug
    favEntity.name = gameModel.name
    favEntity.descript = gameModel.description ?? ""
    favEntity.released = gameModel.released ?? ""
    favEntity.backgroundImage = gameModel.imageBackground ?? ""
    favEntity.rating = gameModel.rating ?? 0
    favEntity.ratingTop = gameModel.ratingTop ?? 0
    favEntity.ratingsCount = gameModel.ratingsCount ?? 0
    for platform in gameModel.parentPlatforms! {
      favEntity.parentPlatforms.append(platform.platform.name)
    }
    for genre in gameModel.genres! {
      favEntity.genres.append(genre.name)
    }
    for tag in gameModel.tags! {
      favEntity.genres.append(tag.name)
    }
    return favEntity
  }
}
