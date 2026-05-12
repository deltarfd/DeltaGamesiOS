import XCTest

final class AdvancedMapperTests: XCTestCase {
    func testGameMapperMapGameResponsesToDomainsMapsNestedCollections() {
        let response = GameResponse(
            id: 44,
            slug: "elden-ring",
            name: "Elden Ring",
            description: "Open world RPG",
            released: "2022-02-25",
            imageBackground: "bg.png",
            rating: 4.9,
            ratingTop: 5,
            ratingsCount: 999,
            genres: [GenreResponse(id: 1, slug: "rpg", name: "RPG", gamesCount: 100, imageBackground: "genre.png")],
            parentPlatforms: [PlatformResponse(platform: PlatformResponse.ChildPlatformResponse(id: 10, slug: "pc", name: "PC"))],
            tags: [TagsResponse(id: 11, slug: "soulslike", name: "Soulslike", language: "en", gamesCount: 10, imageBackground: "tag.png")]
        )

        let result = GameMapper.mapGameResponsesToDomains(input: response)

        XCTAssertEqual(result.id, 44)
        XCTAssertEqual(result.name, "Elden Ring")
        XCTAssertEqual(result.genres?.first?.name, "RPG")
        XCTAssertEqual(result.parentPlatforms?.first?.platform.name, "PC")
        XCTAssertEqual(result.tags?.first?.name, "Soulslike")
    }

    func testGameMapperMapGameDomainsToEntitiesMapsTagsToTagsCollection() {
        let model = GameModel(
            id: 21,
            slug: "game",
            name: "Game",
            description: "desc",
            released: "2025-01-01",
            imageBackground: "img",
            rating: 4.2,
            ratingTop: 5,
            ratingsCount: 120,
            genres: [GenreModel(id: 1, slug: "action", name: "Action", gamesCount: 0, imageBackground: nil)],
            parentPlatforms: [PlatformModel(platform: PlatformModel.ChildPlatformModel(name: "iOS"))],
            tags: [TagsModel(id: 1, slug: "coop", name: "Co-op", language: "", gamesCount: 0, imageBackground: "")]
        )

        let entity = GameMapper.mapGameDomainsToEntities(input: model)

        XCTAssertEqual(entity.id, 21)
        XCTAssertEqual(entity.parentPlatforms, ["iOS"])
        XCTAssertEqual(entity.genres, ["Action"])
        XCTAssertEqual(entity.tags, ["Co-op"])
    }

    func testFavoriteMapperMapFavoriteEntitiesToDomainsMapsArrays() {
        let entity = FavoriteEntity()
        entity.id = 5
        entity.slug = "slug"
        entity.name = "Name"
        entity.descript = "Desc"
        entity.released = "2024-02-02"
        entity.backgroundImage = "cover"
        entity.rating = 4.4
        entity.ratingTop = 5
        entity.ratingsCount = 50
        entity.genres = ["Action"]
        entity.parentPlatforms = ["PC"]
        entity.tags = ["Singleplayer"]

        let result = FavoriteMapper.mapFavoriteEntitiesToDomains(input: [entity])

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 5)
        XCTAssertEqual(result.first?.genres?.first?.name, "Action")
        XCTAssertEqual(result.first?.parentPlatforms?.first?.platform.name, "PC")
        XCTAssertEqual(result.first?.tags?.first?.name, "Singleplayer")
    }

    func testFavoriteMapperMapGameDomainsToEntitiesMapsTagsToTagsCollection() {
        let model = GameModel(
            id: 9,
            slug: "slug",
            name: "Name",
            description: "desc",
            released: "2024-01-01",
            imageBackground: "img",
            rating: 3.9,
            ratingTop: 5,
            ratingsCount: 7,
            genres: [GenreModel(id: 1, slug: "adventure", name: "Adventure", gamesCount: 0, imageBackground: nil)],
            parentPlatforms: [PlatformModel(platform: PlatformModel.ChildPlatformModel(name: "PlayStation"))],
            tags: [TagsModel(id: 2, slug: "story-rich", name: "Story Rich", language: "", gamesCount: 0, imageBackground: "")]
        )

        let entity = FavoriteMapper.mapGameDomainsToEntities(input: model)

        XCTAssertEqual(entity.genres, ["Adventure"])
        XCTAssertEqual(entity.parentPlatforms, ["PlayStation"])
        XCTAssertEqual(entity.tags, ["Story Rich"])
    }

    // MARK: - GamesMapper tests

    func testGamesMapperMapResponsestoEntities() {
        let response = GameResponse(
            id: 1, slug: "s", name: "N", description: "D", released: "2022-01-01",
            imageBackground: "bg", rating: 4.0, ratingTop: 5, ratingsCount: 100,
            genres: [GenreResponse(id: 1, slug: "action", name: "Action", gamesCount: 10, imageBackground: nil)],
            parentPlatforms: [PlatformResponse(platform: PlatformResponse.ChildPlatformResponse(id: 1, slug: "pc", name: "PC"))],
            tags: [TagsResponse(id: 1, slug: "indie", name: "Indie", language: "en", gamesCount: 5, imageBackground: nil)]
        )
        let entities = GamesMapper.mapGamesResponsesToEntities(input: [response])
        XCTAssertEqual(entities.count, 1)
        XCTAssertEqual(entities.first?.id, 1)
        XCTAssertEqual(entities.first?.genres, ["Action"])
        XCTAssertEqual(entities.first?.parentPlatforms, ["PC"])
    }

    func testGamesMapperMapEntitiesToDomains() {
        let entity = GameEntity()
        entity.id = 2; entity.slug = "sl"; entity.name = "Nm"
        entity.descript = "Desc"; entity.released = "2022-01-01"
        entity.backgroundImage = "bg"; entity.rating = 4.1; entity.ratingTop = 5; entity.ratingsCount = 10
        entity.genres = ["RPG"]; entity.parentPlatforms = ["Mac"]; entity.tags = ["Singleplayer"]
        let domains = GamesMapper.mapGamesEntitiesToDomains(input: [entity])
        XCTAssertEqual(domains.first?.id, 2)
        XCTAssertEqual(domains.first?.genres?.first?.name, "RPG")
        XCTAssertEqual(domains.first?.tags?.first?.name, "Singleplayer")
    }

    func testGamesMapperMapResponsesToDomainsDirect() {
        let response = GameResponse(
            id: 3, slug: "sl", name: "Nm", description: nil, released: nil,
            imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil,
            genres: [], parentPlatforms: [], tags: []
        )
        let domains = GamesMapper.mapGamesResponsesToDomains(input: [response])
        XCTAssertEqual(domains.first?.id, 3)
        XCTAssertNil(domains.first?.description)
    }

    // MARK: - TrendingMapper tests

    func testTrendingMapperMapResponsesToEntities() {
        let response = TrendingResponse(
            id: 10, slug: "tr", name: "Trending", description: "Desc", released: "2023-01-01",
            imageBackground: "bg", rating: 4.5, ratingTop: 5, ratingsCount: 200,
            genres: [GenreResponse(id: 2, slug: "action", name: "Action", gamesCount: 10, imageBackground: nil)],
            parentPlatforms: [PlatformResponse(platform: PlatformResponse.ChildPlatformResponse(id: 2, slug: "ps", name: "PS5"))],
            tags: [TagsResponse(id: 2, slug: "coop", name: "Co-op", language: "en", gamesCount: 5, imageBackground: nil)]
        )
        let entities = TrendingMapper.mapTrendingResponsesToEntities(input: [response])
        XCTAssertEqual(entities.count, 1)
        XCTAssertEqual(entities.first?.id, 10)
        XCTAssertEqual(entities.first?.parentPlatforms, ["PS5"])
    }

    func testTrendingMapperMapEntitiesToDomains() {
        let entity = TrendingEntity()
        entity.id = 11; entity.slug = "tr"; entity.name = "T"
        entity.descript = "D"; entity.released = "2023-01-01"
        entity.backgroundImage = "bg"; entity.rating = 4.2; entity.ratingTop = 5; entity.ratingsCount = 50
        entity.genres = ["Action"]; entity.parentPlatforms = ["Xbox"]; entity.tags = ["Multiplayer"]
        let domains = TrendingMapper.mapTrendingEntitiesToDomains(input: [entity])
        XCTAssertEqual(domains.first?.id, 11)
        XCTAssertEqual(domains.first?.genres?.first?.name, "Action")
        XCTAssertEqual(domains.first?.tags?.first?.name, "Multiplayer")
    }
}
