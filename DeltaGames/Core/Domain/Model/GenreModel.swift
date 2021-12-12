//
//  GenreModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

struct GenreModel: Identifiable, Equatable {
    var id: Int = 0
    var slug: String = ""
    var name: String = ""
    var gamesCount: Int? = 0
    var imageBackground: String? = ""
}
