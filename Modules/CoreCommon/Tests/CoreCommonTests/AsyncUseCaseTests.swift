import XCTest
@testable import CoreCommon

final class AsyncUseCaseTests: XCTestCase {

  func testAsyncUseCaseReturnsExpectedValue() async throws {
    struct MultiplyUseCase: AsyncUseCase {
      func execute(_ request: (Int, Int)) async throws -> Int {
        request.0 * request.1
      }
    }

    let useCase = MultiplyUseCase()
    let result = try await useCase.execute((4, 5))
    XCTAssertEqual(result, 20)
  }

  func testAsyncUseCaseWithNoRequest() async throws {
    struct EchoUseCase: AsyncUseCase {
      func execute(_ request: NoRequest) async throws -> NoRequest {
        return request
      }
    }

    let useCase = EchoUseCase()
    let result = try await useCase.execute(.none)
    XCTAssertEqual(result, .none)
  }

  func testAsyncUseCaseThrowsOnError() async {
    struct TestError: Error {}

    struct ThrowingUseCase: AsyncUseCase {
      func execute(_ request: NoRequest) async throws -> String {
        throw TestError()
      }
    }

    let useCase = ThrowingUseCase()
    do {
      _ = try await useCase.execute(.none)
      XCTFail("Expected error to be thrown")
    } catch {
      XCTAssertTrue(error is TestError)
    }
  }

  func testAsyncUseCaseWithStringResponse() async throws {
    struct GreetUseCase: AsyncUseCase {
      func execute(_ request: String) async throws -> String {
        "Hello, \(request)!"
      }
    }

    let useCase = GreetUseCase()
    let result = try await useCase.execute("World")
    XCTAssertEqual(result, "Hello, World!")
  }

  func testAsyncUseCaseZeroMultiplication() async throws {
    struct MultiplyUseCase: AsyncUseCase {
      func execute(_ request: (Int, Int)) async throws -> Int {
        request.0 * request.1
      }
    }

    let result = try await MultiplyUseCase().execute((0, 99))
    XCTAssertEqual(result, 0)
  }
}
