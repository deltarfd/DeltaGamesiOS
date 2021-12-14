//
//  RemoteDataSource.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 09/11/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {

  func getGames() -> AnyPublisher<[GameResponse], Error>
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[TrendingResponse], Error>
  func getDetailGame(from id: String) -> AnyPublisher<GameResponse, Error>
  func getSearchGames(search: String) -> AnyPublisher<[GameResponse], Error>
  
}

final class RemoteDataSource: NSObject {

  private override init() { }
  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
  
  func getGames() -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { result in
      guard let url = URL(string: Endpoints.Gets.games.url) else { return }

      AF.request(url)
        .validate()
        .responseDecodable(of: ResultsGamesResponse.self) { response in
          switch response.result {
          case .success(let value): result(.success(value.results))
          case .failure: result(.failure(URLError.invalidResponse))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[TrendingResponse], Error> {
    return Future<[TrendingResponse], Error> { result in
      guard let url = URL(string: Endpoints.Gets.trending.url + "&ordering=\(ordering)&discover=\(discover)") else { return }

      AF.request(url)
        .validate()
        .responseDecodable(of: ResultsTrendingResponse.self) { response in
          switch response.result {
          case .success(let value): result(.success(value.results))
          case .failure: result(.failure(URLError.invalidResponse))
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailGame(from id: String) -> AnyPublisher<GameResponse, Error> {
    return Future<GameResponse, Error> { result in
      guard let url = URL(string: Endpoints.Gets.detail.url + "\(id)?key=\(API.apiKey)") else { return }

      AF.request(url)
        .validate()
        .responseDecodable(of: GameResponse.self) { response in
        switch response.result {
        case .success(let value): result(.success(value))
        case .failure: result(.failure(URLError.invalidResponse))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func getSearchGames(search: String) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { result in
      guard let url = URL(string: Endpoints.Gets.games.url + "&search='\(search)'") else { return }

      AF.request(url)
        .validate()
        .responseDecodable(of: ResultsGamesResponse.self) { response in
        switch response.result {
        case .success(let value): result(.success(value.results))
        case .failure: result(.failure(URLError.invalidResponse))
        }
      }
    }.eraseToAnyPublisher()
  }
}
