//
//  LocaleDataSource.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 09/11/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
  func getGames() -> AnyPublisher<[GameEntity], Error>
  func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
  func getTrending() -> AnyPublisher<[TrendingEntity], Error>
  func addTrending(from games: [TrendingEntity]) -> AnyPublisher<Bool, Error>
  func getFavGames() -> AnyPublisher<[GameEntity], Error>
  func addFavGame(from game: GameEntity) -> AnyPublisher<Bool, Error>
  func delFavGame(from id: String) -> AnyPublisher<Bool, Error>
  func isFavGame(from id: String) -> AnyPublisher<Bool, Error>
  
}

final class LocaleDataSource: NSObject {

  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }

}

extension LocaleDataSource: LocaleDataSourceProtocol {
  
  func getGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { result in
        if let realm = self.realm {
          let games: Results<GameEntity> = {
              realm.objects(GameEntity.self)
                  .sorted(byKeyPath: "name", ascending: true)
          }()
          result(.success(games.toArray(ofType: GameEntity.self)))
        } else {
          result(.failure(DatabaseError.invalidInstance))
        }
    }.eraseToAnyPublisher()
  }
  
  func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { result in
        if let realm = self.realm {
          do {
            try realm.write {
              for game in games {
                realm.add(game, update: .all)
              }
              result(.success(true))
            }
          } catch {
            result(.failure(DatabaseError.requestFailed))
          }
        } else {
          result(.failure(DatabaseError.invalidInstance))
        }
    }.eraseToAnyPublisher()
  }
  
  func getTrending() -> AnyPublisher<[TrendingEntity], Error> {
    return Future<[TrendingEntity], Error> { result in
        if let realm = self.realm {
          let games: Results<TrendingEntity> = {
              realm.objects(TrendingEntity.self)
                  .sorted(byKeyPath: "name", ascending: true)
          }()
          result(.success(games.toArray(ofType: TrendingEntity.self)))
        } else {
          result(.failure(DatabaseError.invalidInstance))
        }
    }.eraseToAnyPublisher()
  }
  
  func addTrending(from games: [TrendingEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { result in
        if let realm = self.realm {
          do {
            try realm.write {
              for game in games {
                realm.add(game, update: .all)
              }
              result(.success(true))
            }
          } catch {
            result(.failure(DatabaseError.requestFailed))
          }
        } else {
          result(.failure(DatabaseError.invalidInstance))
        }
    }.eraseToAnyPublisher()
  }
  
  func getFavGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { result in
        if let realm = self.realm {
          let games: Results<GameEntity> = {
              realm.objects(GameEntity.self)
                  .sorted(byKeyPath: "name", ascending: true)
          }()
          result(.success(games.toArray(ofType: GameEntity.self)))
        } else {
          result(.failure(DatabaseError.invalidInstance))
        }
    }.eraseToAnyPublisher()
  }
  
  func addFavGame(from game: GameEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { result in
        if let realm = self.realm {
          do {
            try realm.write {
              realm.add(game, update: .all)
              result(.success(true))
            }
          } catch {
            result(.failure(DatabaseError.requestFailed))
          }
        } else {
          result(.failure(DatabaseError.invalidInstance))
        }
    }.eraseToAnyPublisher()
  }
  
  func delFavGame(from id: String) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { result in
          if let realm = self.realm {
              if let gameEntity = {
                  realm.objects(GameEntity.self).filter("id = \(id)")
              }().first {
                  do {
                      try realm.write {
                        realm.delete(gameEntity)
                        result(.success(true))
                      }
                  } catch {
                    result(.failure(DatabaseError.requestFailed))
                  }
              }
          } else {
            result(.failure(DatabaseError.invalidInstance))
          }
      }.eraseToAnyPublisher()
  }
  
  func isFavGame(from id: String) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { result in
          if let realm = self.realm {
            if realm.objects(GameEntity.self).filter("id = \(id)").first != nil {
              result(.success(true))
            } else {
              result(.success(false))
            }
          } else {
            result(.failure(DatabaseError.invalidInstance))
          }
      }.eraseToAnyPublisher()
  }
  
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
