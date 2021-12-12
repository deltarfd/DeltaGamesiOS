//
//  GenreMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

final class GenreMapper {

  static func mapGenreResponsesToEntities(
    input genreResponses: [GenreResponse]
  ) -> [GenreEntity] {
    return genreResponses.map { result in
      let newGenre = GenreEntity()
      newGenre.id = result.id
      newGenre.name = result.name
      newGenre.slug = result.slug
      newGenre.imageBackground = result.imageBackground ?? "Unknow"
      newGenre.gamesCount = result.gamesCount ?? 0
      return newGenre
    }
  }
  
  static func mapGenreDomainsToEntities(
    input genreDomains: [GenreModel]
  ) -> [GenreEntity] {
    return genreDomains.map { result in
      let newGenre = GenreEntity()
      newGenre.id = result.id
      newGenre.name = result.name
      newGenre.slug = result.slug
      newGenre.imageBackground = result.imageBackground ?? "Unknow"
      newGenre.gamesCount = result.gamesCount ?? 0
      return newGenre
    }
  }

  static func mapGenreEntitiesToDomains(
    input genreEntities: [GenreEntity]
  ) -> [GenreModel] {
    return genreEntities.map { result in
      return GenreModel(
        id: result.id,
        slug: result.slug,
        name: result.name,
        gamesCount: result.gamesCount,
        imageBackground: result.imageBackground
      )
    }
  }

  static func mapGenreResponsesToDomains(
    input genreResponses: [GenreResponse]
  ) -> [GenreModel] {
    return genreResponses.map { result in
      return GenreModel(
        id: result.id,
        slug: result.slug,
        name: result.name,
        gamesCount: result.gamesCount ?? 0,
        imageBackground: result.imageBackground
      )
    }
  }
  
}
