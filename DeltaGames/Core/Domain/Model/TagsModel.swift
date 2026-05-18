//
//  TagsModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

struct TagsModel: Identifiable, Equatable {
    var id: Int = 0
    var slug: String = ""
    var name: String = ""
    var language: String = ""
    var gamesCount: Int = 0
    var imageBackground: String = ""
}
