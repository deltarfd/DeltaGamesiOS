//
//  GamesRepository.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 09/11/21.
//

import Foundation
import Combine

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

final class GamesRepository: NSObject {

  typealias GamesInstance = (LocaleDataSource, RemoteDataSource) -> GamesRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: GamesInstance = { localeRepo, remoteRepo in
    return GamesRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension GamesRepository: GamesRepositoryProtocol {
  
  func getGames() -> AnyPublisher<[GameModel], Error> {
    return self.locale.getGames()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return self.remote.getGames()
            .map { GamesMapper.mapGamesResponsesToEntities(input: $0) }
            .flatMap { self.locale.addGames(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getGames()
              .map { GamesMapper.mapGamesEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getGames()
            .map { GamesMapper.mapGamesEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModel], Error> {
    return self.locale.getTrending()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return self.remote.getTrending(ordering: ordering, discover: discover)
            .map { TrendingMapper.mapGamesResponsesToTrendingEntities(input: $0) }
            .flatMap { self.locale.addTrending(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.locale.getTrending()
              .map { TrendingMapper.mapTrendingEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.locale.getGames()
            .map { GamesMapper.mapGamesEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getSearchGames(search: String) -> AnyPublisher<[GameModel], Error> {
    return self.remote.getSearchGames(search: search)
      .map { GamesMapper.mapGamesResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getDetailGame(from id: String) -> AnyPublisher<GameModel, Error> {
    return self.remote.getDetailGame(from: id)
      .map { GameMapper.mapGameResponsesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
  
  func getFavGames() -> AnyPublisher<[GameModel], Error> {
    return self.locale.getFavGames()
      .map { GamesMapper.mapGamesEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }
    
  func addFavGame(from game: GameModel) -> AnyPublisher<Bool, Error> {
    let entity = GameMapper.mapGameDomainsToEntities(input: game)
    return self.locale.addFavGame(from: entity)
        .eraseToAnyPublisher()
  }
 
  func delFavGame(from id: String) -> AnyPublisher<Bool, Error> {
    return self.locale.delFavGame(from: id)
        .eraseToAnyPublisher()
  }
  
  func isFavGame(from id: String) -> AnyPublisher<Bool, Error> {
  return self.locale.isFavGame(from: id)
      .eraseToAnyPublisher()
}

}
