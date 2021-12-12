//
//  TagsResponse.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 05/10/21.
//

import Foundation

struct TagsResponse: Identifiable, Codable {
    let id: Int
    let slug: String
    let name: String
    let language: String
    let gamesCount: Int
    let imageBackground: String
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case language
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
