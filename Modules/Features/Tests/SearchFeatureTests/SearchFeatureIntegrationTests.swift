import XCTest
import CoreCommon
@testable import SearchFeature

final class SearchFeatureIntegrationTests: XCTestCase {

  func testSearchFeatureContractIsIdempotent() throws {
    let contract = SearchFeatureContract()
    let result1 = try contract.execute(.none)
    let result2 = try contract.execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testSearchFeatureContractResponseIsNonEmpty() throws {
    let contract = SearchFeatureContract()
    let result = try contract.execute(.none)
    XCTAssertFalse(result.isEmpty)
  }

  func testSearchFeatureContractConformsToUseCase() {
    // Verifies the module exports a valid UseCase conformance consumable by the host app
    let contract: any UseCase = SearchFeatureContract()
    XCTAssertNotNil(contract)
  }

  func testSearchFeatureContractMultipleInstancesReturnSameResult() throws {
    let result1 = try SearchFeatureContract().execute(.none)
    let result2 = try SearchFeatureContract().execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testSearchFeatureContractResponseContainsSearchFeatureLabel() throws {
    let result = try SearchFeatureContract().execute(.none)
    XCTAssertTrue(result.localizedCaseInsensitiveContains("search"))
  }
}
