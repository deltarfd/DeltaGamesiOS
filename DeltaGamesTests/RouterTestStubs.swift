import Combine
import SwiftUI

final class Injection {
    func provideDetail(game: GameModel) -> DetailUseCase {
        DetailUseCaseMock()
    }
}

struct DetailView: View {
    let presenter: DetailPresenter
    let onDismiss: ((FavoriteChange?) -> Void)?

    init(presenter: DetailPresenter, onDismiss: ((FavoriteChange?) -> Void)? = nil) {
        self.presenter = presenter
        self.onDismiss = onDismiss
    }

    var body: some View {
        EmptyView()
    }
}

private final class DetailUseCaseMock: DetailUseCase {
    func getDetailGame(from id: String) -> AnyPublisher<GameModel, Error> {
        Just(GameModel(id: Int(id) ?? 0, name: "Mock"))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func addFavGame(from id: GameModel) -> AnyPublisher<Bool, Error> {
        Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func delFavGame(from id: String) -> AnyPublisher<Bool, Error> {
        Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func isFavGame(from id: String) -> AnyPublisher<Bool, Error> {
        Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
