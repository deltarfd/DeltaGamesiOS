import XCTest
import Combine
@testable import DeltaGames

final class FavoritePresenterTests: XCTestCase {
    @MainActor
    func testHandleAppearLoadsWhenEmpty() {
        let useCase = FavoriteUseCaseMock()
        useCase.publisher = Just([GameModel(id: 9, slug: "s", name: "N", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = FavoritePresenter(favoriteUseCase: useCase)

        presenter.handleAppear()
        waitForMainQueue()

        XCTAssertEqual(useCase.callCount, 1)
        XCTAssertEqual(presenter.favGames.count, 1)
        XCTAssertFalse(presenter.loadingState)
    }

    @MainActor
    func testHandleAppearRefreshesAfterFavoritesNotification() {
        let useCase = FavoriteUseCaseMock()
        useCase.publisher = Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = FavoritePresenter(favoriteUseCase: useCase)
        presenter.favGames = [GameModel(id: 1, slug: "a", name: "A", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)]

        NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
        waitForMainQueue()
        presenter.handleAppear()
        waitForMainQueue()

        XCTAssertEqual(useCase.callCount, 1)
    }

    @MainActor
    func testApplyFavoriteChangeInsertAndRemoveFlow() {
        let useCase = FavoriteUseCaseMock()
        let presenter = FavoritePresenter(favoriteUseCase: useCase)
        let game = GameModel(id: 7, slug: "g", name: "Game", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)

        presenter.applyFavoriteChange(FavoriteChange(game: game, isFavorite: true))
        XCTAssertEqual(presenter.favGames.count, 1)

        presenter.applyFavoriteChange(FavoriteChange(game: game, isFavorite: false))
        XCTAssertTrue(presenter.favGames.isEmpty)
    }

    @MainActor
    func testApplyFavoriteChangeUpdatesExistingItem() {
        let useCase = FavoriteUseCaseMock()
        let presenter = FavoritePresenter(favoriteUseCase: useCase)
        presenter.favGames = [GameModel(id: 7, slug: "old", name: "Old", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)]
        let updated = GameModel(id: 7, slug: "new", name: "New", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)

        presenter.applyFavoriteChange(FavoriteChange(game: updated, isFavorite: true))

        XCTAssertEqual(presenter.favGames.count, 1)
        XCTAssertEqual(presenter.favGames.first?.name, "New")
    }

    @MainActor
    func testApplyFavoriteChangeIgnoresNil() {
        let useCase = FavoriteUseCaseMock()
        let presenter = FavoritePresenter(favoriteUseCase: useCase)
        presenter.favGames = [GameModel()]

        presenter.applyFavoriteChange(nil)

        XCTAssertEqual(presenter.favGames.count, 1)
    }

    @MainActor
    func testHandleAppearDoesNotRefreshWithoutFlag() {
        let useCase = FavoriteUseCaseMock()
        let presenter = FavoritePresenter(favoriteUseCase: useCase)
        presenter.favGames = [GameModel()]

        presenter.handleAppear()

        XCTAssertEqual(useCase.callCount, 0)
    }

    @MainActor
    func testRefreshFavoritesFailureSetsError() {
        let useCase = FavoriteUseCaseMock()
        useCase.publisher = Fail(error: NSError(domain: "Test", code: 31)).eraseToAnyPublisher()
        let presenter = FavoritePresenter(favoriteUseCase: useCase)

        presenter.refreshFavorites(showsLoading: true)
        waitForMainQueue()

        XCTAssertFalse(presenter.errorMessage.isEmpty)
        XCTAssertFalse(presenter.loadingState)
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

private final class FavoriteUseCaseMock: FavoriteUseCase {
    var callCount = 0
    var publisher: AnyPublisher<[GameModel], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    func getFavGames() -> AnyPublisher<[GameModel], Error> {
        callCount += 1
        return publisher
    }
}
