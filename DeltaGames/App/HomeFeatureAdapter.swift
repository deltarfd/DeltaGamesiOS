//
//  HomeFeatureAdapter.swift
//  DeltaGames
//
//  Integration adapter showing how to use HomeFeature protocols
//
//  Implementation Guide:
//  1. Make existing GameModel conform to GameModelProtocol
//  2. Make existing HomeUseCase conform to HomeUseCaseProtocol
//  3. Make existing HomePresenter conform to HomePresenterProtocol
//  4. Use this adapter to create views
//

import SwiftUI
import Combine

// MARK: - Protocol Conformance Extensions

/// Extend existing GameModel to conform to HomeFeature protocols
extension GameModel {
  // Already has: id, name, backgroundImage
  // Just needs explicit conformance declaration
}

/// Extend existing HomeUseCase to conform to HomeFeature protocols  
extension HomeUseCase {
  // Already has getGames() and getTrending() methods
  // Just needs explicit conformance declaration
}

/// Extend existing HomePresenter to conform to HomeFeature protocols
extension HomePresenter {
  // Already has: trending, games, errorMessage, loadingTrending, loadingGames
  // Already has: getGames(), getTrending() methods
  // Just needs explicit conformance declaration
}

// MARK: - Factory Implementation

/// Home feature view factory for the main app
struct HomeFeatureViewFactory {
  /// Creates a home view integrated with features package
  static func createHomeView() -> some View {
    let homeUseCase = Injection.init().provideHome()
    let presenter = HomePresenter(homeUseCase: homeUseCase)
    return HomeView(presenter: presenter)
  }
  
  /// Alternative: Using the Features package factory (when app types conform to protocols)
  static func createHomeViewFromFeature() -> AnyView {
    let homeUseCase = Injection.init().provideHome()
    // Once GameModel and HomeUseCase conform to protocols:
    // return HomeFeatureFactory.makeHomeView(
    //   homeUseCase: homeUseCase,
    //   detailViewBuilder: { game in
    //     // Create detail view
    //   }
    // )
    return AnyView(EmptyView()) // Placeholder
  }
}

// MARK: - Integration Usage Example

/// Example showing how DeltaGamesApp would use the integrated feature
struct HomeFeatureIntegrationExample {
  static let exampleCode = """
  // In DeltaGamesApp.swift
  
  @main
  struct DeltaGamesApp: App {
    var body: some Scene {
      WindowGroup {
        MainView()
      }
    }
  }
  
  // In MainView.swift
  struct MainView: View {
    var body: some View {
      TabView {
        // Using the factory (current approach)
        HomeFeatureViewFactory.createHomeView()
          .tabItem {
            Label("Home", systemImage: "house")
          }
          .tag(Tab.home)
        
        // Future: Direct features package usage (once all types conform to protocols)
        // HomeFeatureViewFactory.createHomeViewFromFeature()
        //   .tabItem {
        //     Label("Home", systemImage: "house")
        //   }
        //   .tag(Tab.home)
      }
    }
  }
  """
}
