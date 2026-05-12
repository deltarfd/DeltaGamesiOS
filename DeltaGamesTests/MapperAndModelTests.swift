import XCTest

final class MapperAndModelTests: XCTestCase {
    func testGenreMapperMapsOptionalValues() {
        let response = GenreResponse(
            id: 10,
            slug: "action",
            name: "Action",
            gamesCount: nil,
            imageBackground: nil
        )

        let result = GenreMapper.mapGenreResponsesToDomains(input: [response])

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 10)
        XCTAssertEqual(result.first?.slug, "action")
        XCTAssertEqual(result.first?.name, "Action")
        XCTAssertEqual(result.first?.gamesCount, 0)
        XCTAssertNil(result.first?.imageBackground)
    }

    func testPlatformMapperMapsPlatformName() {
        let response = PlatformResponse(
            platform: PlatformResponse.ChildPlatformResponse(
                id: 1,
                slug: "pc",
                name: "PC"
            )
        )

        let result = PlatformMapper.mapPlatformResponsesToDomains(input: [response])

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.platform.name, "PC")
    }

    func testTagsMapperMapsFallbacksWhenOptionalValuesAreNil() {
        let response = TagsResponse(
            id: 7,
            slug: "singleplayer",
            name: "Singleplayer",
            language: nil,
            gamesCount: nil,
            imageBackground: nil
        )

        let result = TagsMapper.mapTagsResponsesToDomains(input: [response])

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 7)
        XCTAssertEqual(result.first?.language, "")
        XCTAssertEqual(result.first?.gamesCount, 0)
        XCTAssertEqual(result.first?.imageBackground, "")
    }

    func testGameModelDefaultsAreStable() {
        let model = GameModel()

        XCTAssertEqual(model.id, 0)
        XCTAssertEqual(model.slug, "")
        XCTAssertEqual(model.name, "")
        XCTAssertEqual(model.rating, 0.0)
        XCTAssertEqual(model.ratingTop, 0)
        XCTAssertEqual(model.ratingsCount, 0)
        XCTAssertEqual(model.genres?.count, 1)
        XCTAssertEqual(model.tags?.count, 1)
    }
}
