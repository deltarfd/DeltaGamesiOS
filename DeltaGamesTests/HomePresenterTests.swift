import XCTest
import Combine

final class HomePresenterTests: XCTestCase {
    @MainActor
    func testGetGamesSuccessUpdatesState() {
        let useCase = HomeUseCaseMock()
        useCase.gamesPublisher = Just([GameModel(id: 1, slug: "s", name: "G", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = HomePresenter(homeUseCase: useCase)

        presenter.getGames()

        waitForMainQueue()

        XCTAssertEqual(presenter.games.count, 1)
        XCTAssertFalse(presenter.loadingGames)
        XCTAssertEqual(presenter.errorMessage, "")
        XCTAssertEqual(useCase.getGamesCallCount, 1)
    }

    @MainActor
    func testGetGamesFailureSetsError() {
        let useCase = HomeUseCaseMock()
        useCase.gamesPublisher = Fail(error: NSError(domain: "Test", code: 11)).eraseToAnyPublisher()
        let presenter = HomePresenter(homeUseCase: useCase)

        presenter.getGames()

        waitForMainQueue()

        XCTAssertFalse(presenter.loadingGames)
        XCTAssertFalse(presenter.errorMessage.isEmpty)
    }

    @MainActor
    func testGetTrendingSuccessUpdatesState() {
        let useCase = HomeUseCaseMock()
        useCase.trendingPublisher = Just([GameModel(id: 2, slug: "t", name: "T", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = HomePresenter(homeUseCase: useCase)

        presenter.getTrending(ordering: "-relevance", discover: "true")

        waitForMainQueue()

        XCTAssertEqual(presenter.trending.count, 1)
        XCTAssertFalse(presenter.loadingTrending)
        XCTAssertEqual(useCase.getTrendingCallCount, 1)
    }

    @MainActor
    func testGetTrendingFailureSetsError() {
        let useCase = HomeUseCaseMock()
        useCase.trendingPublisher = Fail(error: NSError(domain: "Test", code: 12)).eraseToAnyPublisher()
        let presenter = HomePresenter(homeUseCase: useCase)

        presenter.getTrending(ordering: "-relevance", discover: "true")
        waitForMainQueue()

        XCTAssertFalse(presenter.loadingTrending)
        XCTAssertFalse(presenter.errorMessage.isEmpty)
    }

    @MainActor
    func testGetGamesGuardWhenAlreadyLoadingSkipsRequest() {
        let useCase = HomeUseCaseMock()
        let presenter = HomePresenter(homeUseCase: useCase)
        presenter.loadingGames = true

        presenter.getGames()

        XCTAssertEqual(useCase.getGamesCallCount, 0)
    }

    @MainActor
    func testLoadIfNeededTriggersOnlyOnce() {
        let useCase = HomeUseCaseMock()
        let presenter = HomePresenter(homeUseCase: useCase)

        presenter.loadIfNeeded()
        presenter.loadIfNeeded()

        waitForDelay()

        XCTAssertEqual(useCase.getGamesCallCount, 1)
        XCTAssertEqual(useCase.getTrendingCallCount, 1)
    }

    @MainActor
    private func waitForMainQueue() {
        let expectation = expectation(description: "main")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    @MainActor
    private func waitForDelay() {
        let expectation = expectation(description: "delayed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

private final class HomeUseCaseMock: HomeUseCase {
    var getGamesCallCount = 0
    var getTrendingCallCount = 0

    var gamesPublisher: AnyPublisher<[GameModel], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    var trendingPublisher: AnyPublisher<[GameModel], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    func getGames() -> AnyPublisher<[GameModel], Error> {
        getGamesCallCount += 1
        return gamesPublisher
    }

    func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModel], Error> {
        getTrendingCallCount += 1
        return trendingPublisher
    }
}
