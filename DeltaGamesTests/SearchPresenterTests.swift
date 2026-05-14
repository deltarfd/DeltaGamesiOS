import XCTest
import Combine

final class SearchPresenterTests: XCTestCase {
    @MainActor
    func testLoadInitialGamesSuccess() {
        let useCase = SearchUseCaseMock()
        useCase.publisher = Just([GameModel(id: 3, slug: "a", name: "A", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = SearchPresenter(searchUseCase: useCase)

        presenter.loadInitialGames()
        waitForMainQueue()

        XCTAssertEqual(useCase.lastQuery, "")
        XCTAssertEqual(presenter.searchGames.count, 1)
        XCTAssertFalse(presenter.loadingState)
    }

    @MainActor
    func testGetSearchGamesTrimsQuery() {
        let useCase = SearchUseCaseMock()
        let presenter = SearchPresenter(searchUseCase: useCase)

        presenter.getSearchGames(search: "   zelda   ")
        waitForMainQueue()

        XCTAssertEqual(useCase.lastQuery, "zelda")
    }

    @MainActor
    func testGetSearchGamesEmptyFallsBackToInitial() {
        let useCase = SearchUseCaseMock()
        let presenter = SearchPresenter(searchUseCase: useCase)

        presenter.getSearchGames(search: "   ")
        waitForMainQueue()

        XCTAssertEqual(useCase.lastQuery, "")
    }

    @MainActor
    func testGetSearchGamesFailureSetsError() {
        let useCase = SearchUseCaseMock()
        useCase.publisher = Fail(error: NSError(domain: "Test", code: 21)).eraseToAnyPublisher()
        let presenter = SearchPresenter(searchUseCase: useCase)

        presenter.getSearchGames(search: "xx")
        waitForMainQueue()

        XCTAssertFalse(presenter.errorMessage.isEmpty)
        XCTAssertFalse(presenter.loadingState)
    }

    @MainActor
    func testGetSearchGamesShortQuerySkipsRequest() {
        let useCase = SearchUseCaseMock()
        let presenter = SearchPresenter(searchUseCase: useCase)

        presenter.getSearchGames(search: "x")
        waitForMainQueue()

        XCTAssertNil(useCase.lastQuery)
        XCTAssertEqual(presenter.errorMessage, "")
        XCTAssertFalse(presenter.loadingState)
    }

    @MainActor
    func testResetSearchClearsState() {
        let useCase = SearchUseCaseMock()
        let presenter = SearchPresenter(searchUseCase: useCase)
        presenter.errorMessage = "error"
        presenter.loadingState = true
        presenter.searchGames = [GameModel()]

        presenter.resetSearch()

        XCTAssertEqual(presenter.errorMessage, "")
        XCTAssertFalse(presenter.loadingState)
        XCTAssertTrue(presenter.searchGames.isEmpty)
    }

    @MainActor
    private func waitForMainQueue() {
        let expectation = expectation(description: "main")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

private final class SearchUseCaseMock: SearchUseCase {
    var lastQuery: String?
    var publisher: AnyPublisher<[GameModel], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    func getSearchGames(search: String) -> AnyPublisher<[GameModel], Error> {
        lastQuery = search
        return publisher
    }
}
