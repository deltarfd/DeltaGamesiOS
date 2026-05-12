import Combine
import Foundation

protocol GamesRepositoryProtocol {
    func getGames() -> AnyPublisher<[GameModel], Error>
    func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModel], Error>
    func getSearchGames(search: String) -> AnyPublisher<[GameModel], Error>
    func getDetailGame(from id: String) -> AnyPublisher<GameModel, Error>
    func getFavGames() -> AnyPublisher<[GameModel], Error>
    func addFavGame(from game: GameModel) -> AnyPublisher<Bool, Error>
    func delFavGame(from id: String) -> AnyPublisher<Bool, Error>
    func isFavGame(from id: String) -> AnyPublisher<Bool, Error>
}
