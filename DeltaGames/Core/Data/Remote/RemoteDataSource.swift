//
//  RemoteDataSource.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 09/11/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {

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
      guard let url = URL(string: Endpoints.Gets.games.url) else {
        result(.failure(URLError.invalidURL(Endpoints.Gets.games.url)))
        return
      }

      AF.request(url)
        .validate()
        .responseDecodable(of: ResultsGamesResponse.self) { response in
          switch response.result {
          case .success(let value):
            result(.success(value.results))
          case .failure(let error):
            print("Games API Error: \(error.localizedDescription)")
            result(.failure(error))
          }
        }
    }.eraseToAnyPublisher()
  }
  
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[TrendingResponse], Error> {
    return Future<[TrendingResponse], Error> { result in
      let endpoint = Endpoints.Gets.trending.url + "&ordering=\(ordering)&discover=\(discover)"
      guard let url = URL(string: endpoint) else {
        result(.failure(URLError.invalidURL(endpoint)))
        return
      }

      AF.request(url)
        .validate()
        .responseDecodable(of: ResultsTrendingResponse.self) { response in
          switch response.result {
          case .success(let value):
            result(.success(value.results))
          case .failure(let error):
            print("Trending API Error: \(error.localizedDescription)")
            result(.failure(error))
          }
      }
    }.eraseToAnyPublisher()
  }
  
  func getDetailGame(from id: String) -> AnyPublisher<GameResponse, Error> {
    return Future<GameResponse, Error> { result in
      let endpoint = Endpoints.Gets.detail.url + "\(id)?key=\(API.apiKey)"
      guard let url = URL(string: endpoint) else {
        result(.failure(URLError.invalidURL(endpoint)))
        return
      }

      AF.request(url)
        .validate()
        .responseDecodable(of: GameResponse.self) { response in
        switch response.result {
        case .success(let value):
          result(.success(value))
        case .failure(let error):
          print("Detail API Error: \(error.localizedDescription)")
          result(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
   func getSearchGames(search: String) -> AnyPublisher<[GameResponse], Error> {
     return Future<[GameResponse], Error> { result in
       let query = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? search
       let endpoint = Endpoints.Gets.games.url + "&search=\(query)"
       guard let url = URL(string: endpoint) else {
         result(.failure(URLError.invalidURL(endpoint)))
         return
       }

       AF.request(url)
         .validate()
         .responseDecodable(of: ResultsGamesResponse.self) { response in
         switch response.result {
         case .success(let value):
           result(.success(value.results))
         case .failure(let error):
           print("Search API Error: \(error.localizedDescription)")
           result(.failure(error))
         }
       }
     }.eraseToAnyPublisher()
   }
}
