import Foundation

public protocol UseCase {
  associatedtype Request
  associatedtype Response

  func execute(_ request: Request) throws -> Response
}

public enum NoRequest: Equatable {
  case none
}

public protocol AsyncUseCase {
  associatedtype Request
  associatedtype Response

  func execute(_ request: Request) async throws -> Response
}
