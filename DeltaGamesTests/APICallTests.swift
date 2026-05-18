import XCTest
@testable import DeltaGames

final class APICallTests: XCTestCase {
    override func tearDown() {
        API.resetTestingHooks()
        super.tearDown()
    }

    func testAPIKeyUsesEnvironmentVariableWhenPresent() {
        API.environmentProvider = { ["RAWG_API_KEY": "env_key_123"] }

        XCTAssertEqual(API.apiKey, "env_key_123")
        XCTAssertEqual(try? API.resolveAPIKey(), "env_key_123")
    }

    func testAPIKeyFallsBackToPlistWhenEnvironmentMissing() {
        let temporaryDirectory = FileManager.default.temporaryDirectory
        let plistURL = temporaryDirectory.appendingPathComponent("RawgAPI-Test.plist")
        let plist: NSDictionary = ["API_KEY": "plist_key_456"]
        plist.write(to: plistURL, atomically: true)

        API.environmentProvider = { [:] }
        API.plistPathProvider = { plistURL.path }

        XCTAssertEqual(API.apiKey, "plist_key_456")
        XCTAssertEqual(try? API.resolveAPIKey(), "plist_key_456")
    }

    func testResolveAPIKeyThrowsWhenPlistMissing() {
        API.environmentProvider = { [:] }
        API.plistPathProvider = { nil }

        XCTAssertThrowsError(try API.resolveAPIKey()) { error in
            XCTAssertEqual(error as? APIKeyResolveError, .missingPlist)
        }
    }

    func testResolveAPIKeyThrowsWhenKeyMissing() {
        API.environmentProvider = { [:] }
        API.plistPathProvider = { "/tmp/dummy.plist" }
        API.plistValueProvider = { _ in nil }

        XCTAssertThrowsError(try API.resolveAPIKey()) { error in
            XCTAssertEqual(error as? APIKeyResolveError, .missingAPIKey)
        }
    }

    func testResolveAPIKeyThrowsWhenPlaceholderValue() {
        API.environmentProvider = { [:] }
        API.plistPathProvider = { "/tmp/dummy.plist" }
        API.plistValueProvider = { _ in "_PLACEHOLDER_SET_ENV_VAR_OR_UPDATE_THIS" }

        XCTAssertThrowsError(try API.resolveAPIKey()) { error in
            XCTAssertEqual(error as? APIKeyResolveError, .placeholderValue)
        }
    }

    func testTrendingAndGamesEndpointsIncludeResolvedKey() {
        API.environmentProvider = { ["RAWG_API_KEY": "abc123"] }

        XCTAssertEqual(Endpoints.Gets.trending.url, "https://api.rawg.io/api/games/lists/main?key=abc123")
        XCTAssertEqual(Endpoints.Gets.games.url, "https://api.rawg.io/api/games?key=abc123")
    }

    func testDetailAndSearchEndpointsReturnStaticPathSegments() {
        XCTAssertEqual(Endpoints.Gets.detail.url, "https://api.rawg.io/api/games/")
        XCTAssertEqual(Endpoints.Gets.search.url, "https://api.rawg.io/api/games?search=")
    }
}
