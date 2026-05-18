import XCTest
@testable import DeltaGames

final class AppLanguageAndLocalizationTests: XCTestCase {
    private let appLanguageKey = "app_language"

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: appLanguageKey)
        super.tearDown()
    }

    func testAppLanguageEnglishEffectiveCode() {
        XCTAssertEqual(AppLanguage.english.effectiveLanguageCode, "en")
    }

    func testAppLanguageIndonesianEffectiveCode() {
        XCTAssertEqual(AppLanguage.indonesian.effectiveLanguageCode, "id")
    }

    func testLocalizedTextUsesSelectedLanguageFromUserDefaults() {
        UserDefaults.standard.set(AppLanguage.indonesian.rawValue, forKey: appLanguageKey)

        XCTAssertEqual(L10n.text("tab.home"), "Beranda")
    }

    func testLocalizedTextFallsBackToEnglishWhenKeyMissingInDictionary() {
        UserDefaults.standard.set(AppLanguage.english.rawValue, forKey: appLanguageKey)

        XCTAssertEqual(L10n.text("non.existing.key"), "non.existing.key")
    }
}
