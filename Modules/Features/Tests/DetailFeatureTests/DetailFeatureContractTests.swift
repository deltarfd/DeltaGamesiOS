import XCTest
import CoreCommon
@testable import DetailFeature

final class DetailFeatureContractTests: XCTestCase {
  func testDetailFeatureContractReturnsReadyString() throws {
    let contract = DetailFeatureContract()

    XCTAssertEqual(try contract.execute(.none), "DetailFeatureReady")
  }
}
