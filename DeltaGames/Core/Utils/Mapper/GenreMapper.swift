//
//  GenreMapper.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

final class GenreMapper {

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
