import XCTest
import CoreCommon
@testable import ProfileFeature

final class ProfileFeatureIntegrationTests: XCTestCase {

  func testProfileFeatureContractIsIdempotent() throws {
    let contract = ProfileFeatureContract()
    let result1 = try contract.execute(.none)
    let result2 = try contract.execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testProfileFeatureContractResponseIsNonEmpty() throws {
    let result = try ProfileFeatureContract().execute(.none)
    XCTAssertFalse(result.isEmpty)
  }

  func testProfileFeatureContractConformsToUseCase() {
    let contract: any UseCase = ProfileFeatureContract()
    XCTAssertNotNil(contract)
  }

  func testProfileFeatureContractMultipleInstancesReturnSameResult() throws {
    let result1 = try ProfileFeatureContract().execute(.none)
    let result2 = try ProfileFeatureContract().execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testProfileFeatureContractResponseContainsProfileLabel() throws {
    let result = try ProfileFeatureContract().execute(.none)
    XCTAssertTrue(result.localizedCaseInsensitiveContains("profile"))
  }
}
