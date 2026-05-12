import XCTest
import Combine
import SwiftUI
@testable import HomeFeature
@testable import CoreCommon

final class HomePresenterProtocolTests: XCTestCase {

  private var cancellables = Set<AnyCancellable>()

  // MARK: - GameModelProtocol

  func testGameModelProtocolAllProperties() {
    struct ConcreteGame: GameModelProtocol {
      let id: Int
      let name: String
      let backgroundImage: String
    }

    let game = ConcreteGame(id: 42, name: "Cyberpunk 2077", backgroundImage: "https://img.rawg.io/cyberpunk.jpg")
    XCTAssertEqual(game.id, 42)
    XCTAssertEqual(game.name, "Cyberpunk 2077")
    XCTAssertEqual(game.backgroundImage, "https://img.rawg.io/cyberpunk.jpg")
  }

  func testGameModelProtocolWithEmptyValues() {
    struct EmptyGame: GameModelProtocol {
      let id: Int = 0
      let name: String = ""
      let backgroundImage: String = ""
    }

    let game = EmptyGame()
    XCTAssertEqual(game.id, 0)
    XCTAssertTrue(game.name.isEmpty)
    XCTAssertTrue(game.backgroundImage.isEmpty)
  }

  func testGameModelProtocolWithNegativeId() {
    struct NegativeIdGame: GameModelProtocol {
      let id: Int = -1
      let name: String = "Unknown"
      let backgroundImage: String = ""
    }

    let game = NegativeIdGame()
    XCTAssertEqual(game.id, -1)
    XCTAssertEqual(game.name, "Unknown")
  }

  // MARK: - HomeUseCaseProtocol — success path

  func testHomeUseCaseGetGamesReturnsExpectedGames() {
    class MockUseCase: HomeUseCaseProtocol {
      struct Game: GameModelProtocol {
        let id: Int; let name: String; let backgroundImage: String
      }
      func getGames() -> AnyPublisher<[GameModelProtocol], Error> {
        Just([Game(id: 1, name: "A", backgroundImage: ""), Game(id: 2, name: "B", backgroundImage: "")] as [GameModelProtocol])
          .setFailureType(to: Error.self)
          .eraseToAnyPublisher()
      }
      func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
      }
    }

    let expectation = XCTestExpectation(description: "Two games received")
    var received: [GameModelProtocol] = []

    MockUseCase().getGames()
      .sink(receiveCompletion: { _ in }, receiveValue: { games in
        received = games
        expectation.fulfill()
      })
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(received.count, 2)
    XCTAssertEqual(received.first?.id, 1)
    XCTAssertEqual(received.last?.name, "B")
  }

  func testHomeUseCaseGetTrendingPassesParameters() {
    class ParamCapture: HomeUseCaseProtocol {
      var capturedOrdering: String = ""
      var capturedDiscover: String = ""
      func getGames() -> AnyPublisher<[GameModelProtocol], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
      }
      func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error> {
        capturedOrdering = ordering
        capturedDiscover = discover
        return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
      }
    }

    let capture = ParamCapture()
    let expectation = XCTestExpectation(description: "Parameters captured")

    capture.getTrending(ordering: "-relevance", discover: "true")
      .sink(receiveCompletion: { _ in }, receiveValue: { _ in expectation.fulfill() })
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(capture.capturedOrdering, "-relevance")
    XCTAssertEqual(capture.capturedDiscover, "true")
  }

  // MARK: - HomeUseCaseProtocol — error path

  func testHomeUseCaseGetGamesFailurePropagatesToSubscriber() {
    struct NetworkError: Error, LocalizedError {
      var errorDescription: String? { "Network error" }
    }

    class FailingUseCase: HomeUseCaseProtocol {
      func getGames() -> AnyPublisher<[GameModelProtocol], Error> {
        Fail(error: NetworkError()).eraseToAnyPublisher()
      }
      func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error> {
        Fail(error: NetworkError()).eraseToAnyPublisher()
      }
    }

    let expectation = XCTestExpectation(description: "Failure received")
    var receivedError: Error?

    FailingUseCase().getGames()
      .sink(
        receiveCompletion: { completion in
          if case .failure(let error) = completion {
            receivedError = error
            expectation.fulfill()
          }
        },
        receiveValue: { _ in XCTFail("Should not receive value on failure") }
      )
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 1.0)
    XCTAssertNotNil(receivedError)
    XCTAssertEqual(receivedError?.localizedDescription, "Network error")
  }

  func testHomeUseCaseGetTrendingFailurePropagatesToSubscriber() {
    struct TimeoutError: Error {}

    class FailingUseCase: HomeUseCaseProtocol {
      func getGames() -> AnyPublisher<[GameModelProtocol], Error> {
        Fail(error: TimeoutError()).eraseToAnyPublisher()
      }
      func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error> {
        Fail(error: TimeoutError()).eraseToAnyPublisher()
      }
    }

    let expectation = XCTestExpectation(description: "Trending failure received")

    FailingUseCase().getTrending(ordering: "-added", discover: "false")
      .sink(
        receiveCompletion: { completion in
          if case .failure(let error) = completion {
            XCTAssertTrue(error is TimeoutError)
            expectation.fulfill()
          }
        },
        receiveValue: { _ in }
      )
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 1.0)
  }

  // MARK: - HomeUseCaseProtocol — empty results

  func testHomeUseCaseGetGamesReturnsEmpty() {
    class EmptyUseCase: HomeUseCaseProtocol {
      func getGames() -> AnyPublisher<[GameModelProtocol], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
      }
      func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error> {
        Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
      }
    }

    let expectation = XCTestExpectation(description: "Empty games received")
    var received: [GameModelProtocol] = [GameModelProtocol].init()

    EmptyUseCase().getGames()
      .sink(receiveCompletion: { _ in }, receiveValue: { games in
        received = games
        expectation.fulfill()
      })
      .store(in: &cancellables)

    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(received.isEmpty)
  }

  // MARK: - HomeFeatureFactory

  func testHomeFeatureFactoryWithErrorUseCaseStillBuildsView() {
    class ErrorUseCase: HomeUseCaseProtocol {
      struct TestError: Error {}
      func getGames() -> AnyPublisher<[GameModelProtocol], Error> {
        Fail(error: TestError()).eraseToAnyPublisher()
      }
      func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error> {
        Fail(error: TestError()).eraseToAnyPublisher()
      }
    }

    let view = HomeFeatureFactory.makeHomeView(
      homeUseCase: ErrorUseCase(),
      detailViewBuilder: { _ in AnyView(EmptyView()) }
    )
    XCTAssertNotNil(view)
  }
}
