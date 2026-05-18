//
//  SearchModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 22/11/21.
//

import Foundation

struct SearchModel: Equatable, Identifiable {
  var id: Int = 0
  var slug: String = ""
  var name: String = ""
  var description: String? = ""
  var released: String? = ""
  var imageBackground: String? = ""
  var rating: Double? = 0.0
  var ratingTop: Int? = 0
  var ratingsCount: Int? = 0
  var genres: [GenreModel]? = [GenreModel()]
  var parentPlatforms: [PlatformModel]? = []
  var tags: [TagsModel]? = [TagsModel()]
}
