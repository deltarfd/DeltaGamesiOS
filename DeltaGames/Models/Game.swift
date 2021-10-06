//
//  Game.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: Int
    let slug: String
    let name: String
    let description: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratingsCount: Int
    let genres: [Genre]?
    let parentPlatforms: [Platform]?
    let tags: [Genre]?
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case description
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case genres
        case parentPlatforms = "parent_platforms"
        case tags
    }
}
