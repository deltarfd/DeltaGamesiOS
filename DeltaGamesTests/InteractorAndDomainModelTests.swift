import Combine
import XCTest

final class InteractorAndDomainModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func testHomeInteractorForwardsGamesAndTrending() {
        let repo = RepositoryMock()
        let sut = HomeInteractor(repository: repo)
        let expGames = expectation(description: "games")
        let expTrending = expectation(description: "trending")

        sut.getGames()
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expGames.fulfill() })
            .store(in: &cancellables)

        sut.getTrending(ordering: "-rating", discover: "true")
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expTrending.fulfill() })
            .store(in: &cancellables)

        wait(for: [expGames, expTrending], timeout: 1)
        XCTAssertEqual(repo.lastOrdering, "-rating")
        XCTAssertEqual(repo.lastDiscover, "true")
    }

    func testDetailInteractorForwardsAllActions() {
        let repo = RepositoryMock()
        let sut = DetailInteractor(repository: repo)
        let model = GameModel(id: 99, name: "Test")
        let expDetail = expectation(description: "detail")
        let expAdd = expectation(description: "add")
        let expDel = expectation(description: "del")
        let expIsFav = expectation(description: "isFav")

        sut.getDetailGame(from: "99")
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expDetail.fulfill() })
            .store(in: &cancellables)

        sut.addFavGame(from: model)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expAdd.fulfill() })
            .store(in: &cancellables)

        sut.delFavGame(from: "99")
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expDel.fulfill() })
            .store(in: &cancellables)

        sut.isFavGame(from: "99")
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expIsFav.fulfill() })
            .store(in: &cancellables)

        wait(for: [expDetail, expAdd, expDel, expIsFav], timeout: 1)
        XCTAssertEqual(repo.lastDetailId, "99")
        XCTAssertEqual(repo.lastDeletedId, "99")
        XCTAssertEqual(repo.lastIsFavId, "99")
        XCTAssertEqual(repo.lastAddedGameId, 99)
    }

    func testFavoriteAndSearchInteractorForwardCalls() {
        let repo = RepositoryMock()
        let favorite = FavoriteInteractor(repository: repo)
        let search = SearchInteractor(repository: repo)
        let expFavorite = expectation(description: "favorite")
        let expSearch = expectation(description: "search")

        favorite.getFavGames()
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expFavorite.fulfill() })
            .store(in: &cancellables)

        search.getSearchGames(search: "elden")
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in expSearch.fulfill() })
            .store(in: &cancellables)

        wait(for: [expFavorite, expSearch], timeout: 1)
        XCTAssertEqual(repo.lastSearchQuery, "elden")
    }

    func testProfileInteractorInitializesWithRepository() {
        let repo = RepositoryMock()
        let sut = ProfileInteractor(repository: repo)

        XCTAssertNotNil(sut)
    }

    func testDomainModelDefaults() {
        let favorite = FavoriteModel()
        let search = SearchModel()
        let trending = TrendingModel()

        XCTAssertEqual(favorite.id, 0)
        XCTAssertEqual(search.id, 0)
        XCTAssertEqual(trending.id, 0)
        XCTAssertEqual(favorite.tags?.count, 1)
        XCTAssertEqual(search.genres?.count, 1)
        XCTAssertEqual(trending.parentPlatforms?.count, 0)
    }
}

private final class RepositoryMock: GamesRepositoryProtocol {
    var lastOrdering: String?
    var lastDiscover: String?
    var lastSearchQuery: String?
    var lastDetailId: String?
    var lastDeletedId: String?
    var lastIsFavId: String?
    var lastAddedGameId: Int?

    private let games = [GameModel(id: 1, name: "G1")]

    func getGames() -> AnyPublisher<[GameModel], Error> {
        Just(games).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModel], Error> {
        lastOrdering = ordering
        lastDiscover = discover
        return Just(games).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getSearchGames(search: String) -> AnyPublisher<[GameModel], Error> {
        lastSearchQuery = search
        return Just(games).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getDetailGame(from id: String) -> AnyPublisher<GameModel, Error> {
        lastDetailId = id
        return Just(GameModel(id: Int(id) ?? 0, name: "Detail"))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func getFavGames() -> AnyPublisher<[GameModel], Error> {
        Just(games).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func addFavGame(from game: GameModel) -> AnyPublisher<Bool, Error> {
        lastAddedGameId = game.id
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func delFavGame(from id: String) -> AnyPublisher<Bool, Error> {
        lastDeletedId = id
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func isFavGame(from id: String) -> AnyPublisher<Bool, Error> {
        lastIsFavId = id
        return Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
