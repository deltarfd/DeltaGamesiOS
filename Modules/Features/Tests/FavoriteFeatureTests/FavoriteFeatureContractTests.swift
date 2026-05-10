import XCTest
import CoreCommon
@testable import FavoriteFeature

final class FavoriteFeatureContractTests: XCTestCase {
  func testFavoriteFeatureContractReturnsReadyString() throws {
    let contract = FavoriteFeatureContract()

    XCTAssertEqual(try contract.execute(.none), "FavoriteFeatureReady")
  }
}
