import Foundation
@testable import DeltaGames

final class GameEntity {
    var id: Int = 0
    var slug: String = ""
    var name: String = ""
    var descript: String = ""
    var released: String? = ""
    var backgroundImage: String? = ""
    var rating: Double = 0
    var ratingTop: Int = 0
    var ratingsCount: Int = 0
    var genres: [String] = []
    var parentPlatforms: [String] = []
    var tags: [String] = []
}

final class FavoriteEntity {
    var id: Int = 0
    var slug: String = ""
    var name: String = ""
    var descript: String = ""
    var released: String? = ""
    var backgroundImage: String? = ""
    var rating: Double = 0
    var ratingTop: Int = 0
    var ratingsCount: Int = 0
    var genres: [String] = []
    var parentPlatforms: [String] = []
    var tags: [String] = []
}

final class TrendingEntity {
    var id: Int = 0
    var slug: String = ""
    var name: String = ""
    var descript: String = ""
    var released: String = ""
    var backgroundImage: String = ""
    var rating: Double = 0
    var ratingTop: Int = 0
    var ratingsCount: Int = 0
    var genres: [String] = []
    var parentPlatforms: [String] = []
    var tags: [String] = []
}
