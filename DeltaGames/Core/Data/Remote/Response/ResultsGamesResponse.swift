//
//  ResultsGamesResponse.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import Foundation

struct ResultsGamesResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GameResponse]
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}
