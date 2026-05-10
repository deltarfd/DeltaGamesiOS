//
//  HomeFeatureInterface.swift
//  HomeFeature
//
//  Protocol-based interfaces for Home feature integration
//

import SwiftUI
import Combine

// MARK: - Domain Models (Protocols)

public protocol GameModelProtocol {
  var id: Int { get }
  var name: String { get }
  var backgroundImage: String { get }
}

// MARK: - Use Case Protocols

public protocol HomeUseCaseProtocol {
  func getGames() -> AnyPublisher<[GameModelProtocol], Error>
  func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error>
}

// MARK: - Presenter Protocol

public protocol HomePresenterProtocol: ObservableObject {
  var trending: [GameModelProtocol] { get }
  var games: [GameModelProtocol] { get }
  var errorMessage: String { get }
  var loadingTrending: Bool { get }
  var loadingGames: Bool { get }
  
  func getGames()
  func getTrending(ordering: String, discover: String)
}

// MARK: - Home Feature Factory

public struct HomeFeatureFactory {
  /// Creates a home view with the provided dependencies
  /// - Parameters:
  ///   - homeUseCase: The home use case implementation
  ///   - detailViewBuilder: Closure to build detail view for navigation
  /// - Returns: A view that conforms to the Home feature interface
  public static func makeHomeView(
    homeUseCase: HomeUseCaseProtocol,
    detailViewBuilder: @escaping (GameModelProtocol) -> AnyView
  ) -> AnyView {
    // This factory would be implemented in the main app's integration layer
    // It demonstrates how the feature module would be consumed
    AnyView(EmptyView())
  }
}

