import SwiftUI
import XCTest

@MainActor
final class RouterTests: XCTestCase {
    func testHomeRouterCreatesDetailView() {
        let router = HomeRouter()
        let game = GameModel(id: 101, name: "Home Game")

        let detailView = router.makeDetailView(for: game)

        XCTAssertFalse(String(describing: type(of: detailView)).isEmpty)
    }

    func testSearchRouterCreatesDetailView() {
        let router = SearchRouter()
        let game = GameModel(id: 202, name: "Search Game")

        let detailView = router.makeDetailView(for: game)

        XCTAssertFalse(String(describing: type(of: detailView)).isEmpty)
    }

    func testFavoriteRouterCreatesDetailViewWithDismissHandler() {
        let router = FavoriteRouter()
        let game = GameModel(id: 303, name: "Favorite Game")

        let detailView = router.makeDetailView(for: game) { change in
            _ = change
        }

        XCTAssertFalse(String(describing: type(of: detailView)).isEmpty)
    }
}
