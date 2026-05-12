import XCTest

final class ExtensionsAndErrorsTests: XCTestCase {
    func testDoubleFormattedProducesTwoDecimalsWithSuffix() {
        XCTAssertEqual(4.567.formatted(), "4.57/5")
        XCTAssertEqual(4.567.formatted(maxRating: 10), "4.57/10")
    }

    func testDoubleFormattedRatingOnlyProducesTwoDecimals() {
        XCTAssertEqual(4.5.formattedRatingOnly(), "4.50")
    }

    func testOptionalDoubleFormattedRatingHandlesNilAndValue() {
        let nilValue: Double? = nil
        let value: Double? = 3.333

        XCTAssertEqual(nilValue.formattedRating(), "N/A")
        XCTAssertEqual(value.formattedRating(), "3.33/5")
        XCTAssertEqual(nilValue.formattedRating(nilText: "-") , "-")
    }

    func testUrlErrorDescriptions() {
        XCTAssertEqual(URLError.invalidResponse.errorDescription, "The server responded with garbage.")
        XCTAssertEqual(URLError.invalidURL("bad-url").errorDescription, "The URL is invalid: bad-url")
        XCTAssertEqual(
            URLError.addressUnreachable(URL(string: "https://example.com")!).errorDescription,
            "https://example.com is unreachable."
        )
    }

    func testDatabaseErrorDescriptions() {
        XCTAssertEqual(DatabaseError.invalidInstance.errorDescription, "Database can't instance.")
        XCTAssertEqual(DatabaseError.requestFailed.errorDescription, "Your request failed.")
    }
}
