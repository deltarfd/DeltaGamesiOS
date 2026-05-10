import Foundation
import CoreCommon

public struct SearchFeatureContract: UseCase {
  public typealias Request = NoRequest
  public typealias Response = String

  public init() {}

  public func execute(_ request: NoRequest) throws -> String {
    "SearchFeatureReady"
  }
}
