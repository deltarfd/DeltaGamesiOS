import XCTest
import CoreCommon
@testable import ProfileFeature

final class ProfileFeatureContractTests: XCTestCase {
  func testProfileFeatureContractReturnsReadyString() throws {
    let contract = ProfileFeatureContract()

    XCTAssertEqual(try contract.execute(.none), "ProfileFeatureReady")
  }
}
