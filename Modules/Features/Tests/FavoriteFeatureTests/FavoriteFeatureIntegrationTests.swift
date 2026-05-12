import XCTest
import CoreCommon
@testable import FavoriteFeature

final class FavoriteFeatureIntegrationTests: XCTestCase {

  func testFavoriteFeatureContractIsIdempotent() throws {
    let contract = FavoriteFeatureContract()
    let result1 = try contract.execute(.none)
    let result2 = try contract.execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testFavoriteFeatureContractResponseIsNonEmpty() throws {
    let result = try FavoriteFeatureContract().execute(.none)
    XCTAssertFalse(result.isEmpty)
  }

  func testFavoriteFeatureContractConformsToUseCase() {
    let contract: any UseCase = FavoriteFeatureContract()
    XCTAssertNotNil(contract)
  }

  func testFavoriteFeatureContractMultipleInstancesReturnSameResult() throws {
    let result1 = try FavoriteFeatureContract().execute(.none)
    let result2 = try FavoriteFeatureContract().execute(.none)
    XCTAssertEqual(result1, result2)
  }

  func testFavoriteFeatureContractResponseContainsFavoriteLabel() throws {
    let result = try FavoriteFeatureContract().execute(.none)
    XCTAssertTrue(result.localizedCaseInsensitiveContains("favorite"))
  }
}
