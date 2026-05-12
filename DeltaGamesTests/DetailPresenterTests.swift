import XCTest
import Combine

final class DetailPresenterTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    @MainActor
    func testLoadIfNeededCallsUseCaseOnlyOnce() {
        let useCase = DetailUseCaseMock()
        let presenter = DetailPresenter(id: "99", detailUseCase: useCase)

        presenter.loadIfNeeded()
        presenter.loadIfNeeded()

        waitForMainQueue()

        XCTAssertEqual(useCase.getDetailCallCount, 1)
        XCTAssertEqual(useCase.isFavCallCount, 1)
    }

    @MainActor
    func testGetDetailGameSuccessUpdatesGameAndStopsLoading() {
        let expected = GameModel(id: 7, slug: "slug", name: "Halo", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)
        let useCase = DetailUseCaseMock()
        useCase.getDetailPublisher = Just(expected)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = DetailPresenter(id: "7", detailUseCase: useCase)

        presenter.getDetailGame(from: "7")
        XCTAssertTrue(presenter.loadingState)

        waitForMainQueue()

        XCTAssertFalse(presenter.loadingState)
        XCTAssertEqual(presenter.game.id, 7)
        XCTAssertEqual(presenter.errorMessage, "")
    }

    @MainActor
    func testGetDetailGameFailureUpdatesErrorMessage() {
        let useCase = DetailUseCaseMock()
        useCase.getDetailPublisher = Fail(error: NSError(domain: "Test", code: 1)).eraseToAnyPublisher()
        let presenter = DetailPresenter(id: "7", detailUseCase: useCase)

        presenter.getDetailGame(from: "7")

        waitForMainQueue()

        XCTAssertFalse(presenter.loadingState)
        XCTAssertFalse(presenter.errorMessage.isEmpty)
    }

    @MainActor
    func testAddFavGamePublishesFavoriteChangeAndNotification() {
        let useCase = DetailUseCaseMock()
        useCase.addFavPublisher = Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = DetailPresenter(id: "1", detailUseCase: useCase)
        presenter.game = GameModel(id: 1, slug: "g", name: "Game", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)

        let expectation = expectation(forNotification: .favoritesDidChange, object: nil)

        presenter.addFavGame(from: presenter.game)

        wait(for: [expectation], timeout: 1.0)
        waitForMainQueue()

        XCTAssertTrue(presenter.isFav)
        XCTAssertEqual(presenter.pendingFavoriteChange?.game.id, 1)
        XCTAssertEqual(presenter.pendingFavoriteChange?.isFavorite, true)
    }

    @MainActor
    func testDelFavGameSetsFavoriteFalseAndNotification() {
        let useCase = DetailUseCaseMock()
        useCase.delFavPublisher = Just(true)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        let presenter = DetailPresenter(id: "1", detailUseCase: useCase)
        presenter.game = GameModel(id: 1, slug: "g", name: "Game", description: nil, released: nil, imageBackground: nil, rating: nil, ratingTop: nil, ratingsCount: nil, genres: nil, parentPlatforms: nil, tags: nil)
        presenter.isFav = true

        let expectation = expectation(forNotification: .favoritesDidChange, object: nil)

        presenter.delFavGame(from: "1")

        wait(for: [expectation], timeout: 1.0)
        waitForMainQueue()

        XCTAssertFalse(presenter.isFav)
        XCTAssertEqual(presenter.pendingFavoriteChange?.isFavorite, false)
    }

    @MainActor
    func testIsFavGameFailureUpdatesErrorMessage() {
        let useCase = DetailUseCaseMock()
        useCase.isFavPublisher = Fail(error: NSError(domain: "Test", code: 2)).eraseToAnyPublisher()
        let presenter = DetailPresenter(id: "1", detailUseCase: useCase)

        presenter.isFavGame(from: "1")
        waitForMainQueue()

        XCTAssertFalse(presenter.errorMessage.isEmpty)
    }

    @MainActor
    private func waitForMainQueue() {
        let expectation = expectation(description: "main queue")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}

private final class DetailUseCaseMock: DetailUseCase {
    var getDetailCallCount = 0
    var isFavCallCount = 0

    var getDetailPublisher: AnyPublisher<GameModel, Error> = Just(GameModel())
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    var addFavPublisher: AnyPublisher<Bool, Error> = Just(true)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    var delFavPublisher: AnyPublisher<Bool, Error> = Just(true)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    var isFavPublisher: AnyPublisher<Bool, Error> = Just(false)
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()

    func getDetailGame(from id: String) -> AnyPublisher<GameModel, Error> {
        getDetailCallCount += 1
        return getDetailPublisher
    }

    func addFavGame(from id: GameModel) -> AnyPublisher<Bool, Error> {
        addFavPublisher
    }

    func delFavGame(from id: String) -> AnyPublisher<Bool, Error> {
        delFavPublisher
    }

    func isFavGame(from id: String) -> AnyPublisher<Bool, Error> {
        isFavCallCount += 1
        return isFavPublisher
    }
}
