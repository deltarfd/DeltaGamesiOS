//
//  APICall.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/games"
  static var apiKey: String {
    guard let filePath = Bundle.main.path(forResource: "RawgAPI", ofType: "plist") else {
      fatalError("Couldn't find file 'RawgAPI.plist'.")
    }
    
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'RawgAPI.plist'.")
    }
    
    if value.starts(with: "_") {
      fatalError("Register for a RAWG developer account and get an API key at https://rawg.io/apidocs.")
    }
    return value
  }
}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case trending
    case games
    case detail
    case search
    
    public var url: String {
      switch self {
      case .trending: return "\(API.baseUrl)/lists/main?key=\(API.apiKey)"
      case .games: return "\(API.baseUrl)?key=\(API.apiKey)"
      case .detail: return "\(API.baseUrl)/"
      case .search: return "\(API.baseUrl)?search="
      }
    }
  }
  
}
