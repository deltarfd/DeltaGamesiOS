//
//  Platform.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 02/10/21.
//

import Foundation

struct Platform: Codable {
    let platform: ChildPlatform
    struct ChildPlatform: Identifiable, Codable {
        let id: Int
        let slug: String
        let name: String
    }
}
