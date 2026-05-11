import XCTest
@testable import CoreCommon

final class LocalizationTests: XCTestCase {
  func testLocalizedReturnsFallbackForUnknownKey() {
    let value = CommonLocalization.localized(
      "unknown.key",
      fallback: "Unknown"
    )

    XCTAssertEqual(value, "Unknown")
  }

  func testLocalizedReturnsExistingTranslation() {
    let value = CommonLocalization.localized("tab.home", fallback: "Home")

    XCTAssertEqual(value, "Home")
  }

  func testLocalizedReturnsKeyWhenUnknownAndFallbackEmpty() {
    let value = CommonLocalization.localized("unknown.key.without.fallback")

    XCTAssertEqual(value, "unknown.key.without.fallback")
  }

  func testLocalizedReturnsEmptyWhenKeyAndFallbackAreEmpty() {
    let value = CommonLocalization.localized("", fallback: "")

    XCTAssertEqual(value, "")
  }
}
