import Foundation

public enum CommonLocalization {
  public static func localized(
    _ key: String,
    tableName: String = "Localizable",
    bundle: Bundle? = nil,
    fallback: String = ""
  ) -> String {
    let resolvedBundle = bundle ?? .module
    let value = NSLocalizedString(
      key,
      tableName: tableName,
      bundle: resolvedBundle,
      value: fallback,
      comment: ""
    )

    if value.isEmpty {
      return fallback.isEmpty ? key : fallback
    }

    return value
  }
}
