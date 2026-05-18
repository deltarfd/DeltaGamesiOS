//
//  ResultsTrendingResponse.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 13/12/21.
//

import Foundation

struct ResultsTrendingResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [TrendingResponse]
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}
