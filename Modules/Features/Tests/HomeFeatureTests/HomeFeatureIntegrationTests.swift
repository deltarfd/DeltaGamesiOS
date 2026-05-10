//
//  HomeFeatureIntegrationTests.swift
//  HomeFeatureTests
//
//  Integration tests demonstrating how HomeFeature integrates with the main app
//

import XCTest
import SwiftUI
import Combine
@testable import HomeFeature
@testable import CoreCommon

class HomeFeatureIntegrationTests: XCTestCase {

  // MARK: - Mock Implementations for Testing
  
  class MockGameModel: GameModelProtocol {
    let id: Int
    let name: String
    let backgroundImage: String
    
    init(id: Int = 1, name: String = "TestGame", backgroundImage: String = "url") {
      self.id = id
      self.name = name
      self.backgroundImage = backgroundImage
    }
  }
  
  class MockHomeUseCase: HomeUseCaseProtocol {
    var getGamesCallCount = 0
    var getTrendingCallCount = 0
    
    func getGames() -> AnyPublisher<[GameModelProtocol], Error> {
      getGamesCallCount += 1
      return Just([MockGameModel(id: 1, name: "Game1")])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
    
    func getTrending(ordering: String, discover: String) -> AnyPublisher<[GameModelProtocol], Error> {
      getTrendingCallCount += 1
      return Just([MockGameModel(id: 2, name: "TrendingGame")])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
  }
  
  // MARK: - Integration Tests
  
  func testHomeFeatureProtocolsConformance() {
    // This test verifies that the feature module provides the required protocols
    // for integration with the main app
    let mockUseCase = MockHomeUseCase()
    
    // Verify the protocol exists and can be used
    let useCase: HomeUseCaseProtocol = mockUseCase
    XCTAssertNotNil(useCase)
  }
  
  func testHomeFeatureFactoryAvailability() {
    // Verify that the factory is publicly accessible for the main app
    let factory = HomeFeatureFactory.self
    XCTAssertNotNil(factory)
  }
  
  func testMockHomeUseCaseConformanceToProtocol() {
    let mockUseCase = MockHomeUseCase()
    var receivedGames: [GameModelProtocol] = []
    let expectation = XCTestExpectation(description: "Games received")
    
    mockUseCase.getGames()
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { games in
          receivedGames = games
          expectation.fulfill()
        }
      )
      .store(in: &self.cancellables)
    
    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(receivedGames.count, 1)
    XCTAssertEqual(receivedGames.first?.name, "Game1")
  }
  
  func testHomeUseCaseTrendingCall() {
    let mockUseCase = MockHomeUseCase()
    var receivedTrending: [GameModelProtocol] = []
    let expectation = XCTestExpectation(description: "Trending received")
    
    mockUseCase.getTrending(ordering: "-relevance", discover: "true")
      .sink(
        receiveCompletion: { _ in },
        receiveValue: { trending in
          receivedTrending = trending
          expectation.fulfill()
        }
      )
      .store(in: &self.cancellables)
    
    wait(for: [expectation], timeout: 1.0)
    XCTAssertEqual(receivedTrending.count, 1)
    XCTAssertEqual(mockUseCase.getTrendingCallCount, 1)
  }
  
  // MARK: - Helper
  
  private var cancellables = Set<AnyCancellable>()
}
