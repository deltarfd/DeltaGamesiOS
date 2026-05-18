//
//  PlatformResponse.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import Foundation

struct PlatformResponse: Decodable {
    let platform: ChildPlatformResponse
    struct ChildPlatformResponse: Identifiable, Decodable {
        let id: Int
        let slug: String
        let name: String
    }
}
