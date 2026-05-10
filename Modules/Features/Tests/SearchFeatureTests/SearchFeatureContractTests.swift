import XCTest
import CoreCommon
@testable import SearchFeature

final class SearchFeatureContractTests: XCTestCase {
  func testSearchFeatureContractReturnsReadyString() throws {
    let contract = SearchFeatureContract()

    XCTAssertEqual(try contract.execute(.none), "SearchFeatureReady")
  }
}
