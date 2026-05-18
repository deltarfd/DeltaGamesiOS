//
//  APICall.swift
//  DeltaGames
//
//  Created by Delta Rahmat Fajar Delviansyah on 10/11/21.
//

import Foundation

enum APIKeyResolveError: Error, Equatable {
  case missingPlist
  case missingAPIKey
  case placeholderValue
}

struct API {
  static let baseUrl = "https://api.rawg.io/api/games"

  static var environmentProvider: () -> [String: String] = {
    ProcessInfo.processInfo.environment
  }
  static var plistPathProvider: () -> String? = {
    Bundle.main.path(forResource: "RawgAPI", ofType: "plist")
  }
  static var plistValueProvider: (String) -> String? = { filePath in
    let plist = NSDictionary(contentsOfFile: filePath)
    return plist?.object(forKey: "API_KEY") as? String
  }
  static var fatalErrorHandler: (String, StaticString, UInt) -> Never = { message, file, line in
    Swift.fatalError(message, file: file, line: line)
  }

  static func resetTestingHooks() {
    environmentProvider = {
      ProcessInfo.processInfo.environment
    }
    plistPathProvider = {
      Bundle.main.path(forResource: "RawgAPI", ofType: "plist")
    }
    plistValueProvider = { filePath in
      let plist = NSDictionary(contentsOfFile: filePath)
      return plist?.object(forKey: "API_KEY") as? String
    }
    fatalErrorHandler = { message, file, line in
      Swift.fatalError(message, file: file, line: line)
    }
  }

  static func resolveAPIKey() throws -> String {
    if let envKey = environmentProvider()["RAWG_API_KEY"], !envKey.isEmpty {
      return envKey
    }

    guard let filePath = plistPathProvider() else {
      throw APIKeyResolveError.missingPlist
    }

    guard let value = plistValueProvider(filePath) else {
      throw APIKeyResolveError.missingAPIKey
    }

    if value.starts(with: "_") || value.isEmpty {
      throw APIKeyResolveError.placeholderValue
    }

    return value
  }

  static var apiKey: String {
    do {
      return try resolveAPIKey()
    } catch APIKeyResolveError.missingPlist {
      fatalErrorHandler("Couldn't find file 'RawgAPI.plist'. Set RAWG_API_KEY environment variable or ensure RawgAPI.plist exists.", #filePath, #line)
    } catch APIKeyResolveError.missingAPIKey {
      fatalErrorHandler("Couldn't find key 'API_KEY' in 'RawgAPI.plist'. Set RAWG_API_KEY environment variable or add API_KEY to plist.", #filePath, #line)
    } catch APIKeyResolveError.placeholderValue {
      fatalErrorHandler("API key not configured. Register for a RAWG developer account and get an API key at https://rawg.io/apidocs, then set RAWG_API_KEY environment variable or update RawgAPI.plist.", #filePath, #line)
    } catch {
      fatalErrorHandler("Unexpected API key configuration error.", #filePath, #line)
    }
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
