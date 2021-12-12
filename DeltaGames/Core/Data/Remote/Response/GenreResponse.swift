//
//  GenreResponse.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import Foundation

struct GenreResponse: Identifiable, Decodable {
    let id: Int
    let slug: String
    let name: String
    let gamesCount: Int?
    let imageBackground: String?
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
