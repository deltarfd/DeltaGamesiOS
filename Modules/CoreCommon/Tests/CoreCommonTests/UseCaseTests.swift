import XCTest
@testable import CoreCommon

final class UseCaseTests: XCTestCase {
  func testSyncUseCaseExecute() throws {
    struct SumUseCase: UseCase {
      func execute(_ request: (Int, Int)) throws -> Int {
        request.0 + request.1
      }
    }

    let useCase = SumUseCase()

    XCTAssertEqual(try useCase.execute((10, 15)), 25)
  }

  func testNoRequestIsEquatable() {
    XCTAssertEqual(NoRequest.none, NoRequest.none)
  }
}
