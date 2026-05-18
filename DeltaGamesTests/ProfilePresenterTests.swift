import XCTest
@testable import DeltaGames

@MainActor
final class ProfilePresenterTests: XCTestCase {
    func testInitialStateIsEmptyAndNotLoading() {
        let presenter = ProfilePresenter(profileUseCase: ProfileUseCaseMock())

        XCTAssertTrue(presenter.games.isEmpty)
        XCTAssertEqual(presenter.errorMessage, "")
        XCTAssertFalse(presenter.loadingState)
    }

    func testPublishedPropertiesCanBeMutated() {
        let presenter = ProfilePresenter(profileUseCase: ProfileUseCaseMock())
        let game = GameModel(id: 77, name: "Profile Test Game")

        presenter.games = [game]
        presenter.errorMessage = "sample error"
        presenter.loadingState = true

        XCTAssertEqual(presenter.games.count, 1)
        XCTAssertEqual(presenter.games.first?.id, 77)
        XCTAssertEqual(presenter.errorMessage, "sample error")
        XCTAssertTrue(presenter.loadingState)
    }
}

private struct ProfileUseCaseMock: ProfileUseCase {}
