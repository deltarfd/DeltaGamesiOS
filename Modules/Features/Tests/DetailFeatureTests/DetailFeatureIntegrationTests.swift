import XCTest
import CoreCommon
@testable import DetailFeature

final class DetailFeatureIntegrationTests: XCTestCase {

  func testDetailFeatureContractIsIdempotent() throws {
    let contract = DetailFeatureContract()
    let result1 = try contract.execute(.none)
    let result2 = try contract.execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testDetailFeatureContractResponseIsNonEmpty() throws {
    let result = try DetailFeatureContract().execute(.none)
    XCTAssertFalse(result.isEmpty)
  }

  func testDetailFeatureContractConformsToUseCase() {
    let contract: any UseCase = DetailFeatureContract()
    XCTAssertNotNil(contract)
  }

  func testDetailFeatureContractMultipleInstancesReturnSameResult() throws {
    let result1 = try DetailFeatureContract().execute(.none)
    let result2 = try DetailFeatureContract().execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testDetailFeatureContractResponseContainsDetailLabel() throws {
    let result = try DetailFeatureContract().execute(.none)
    XCTAssertTrue(result.localizedCaseInsensitiveContains("detail"))
  }
}
