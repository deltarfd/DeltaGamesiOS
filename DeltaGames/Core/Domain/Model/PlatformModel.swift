//
//  PlatformModel.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

struct PlatformModel: Equatable {
    let platform: ChildPlatformModel
    struct ChildPlatformModel: Equatable, Identifiable {
        let id: Int
        let slug: String
        let name: String
    }
}
