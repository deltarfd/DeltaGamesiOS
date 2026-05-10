import XCTest
import CoreCommon
@testable import HomeFeature

final class HomeFeatureContractTests: XCTestCase {
  func testHomeFeatureContractReturnsReadyString() throws {
    let contract = HomeFeatureContract()

    XCTAssertEqual(try contract.execute(.none), "HomeFeatureReady")
  }
}
