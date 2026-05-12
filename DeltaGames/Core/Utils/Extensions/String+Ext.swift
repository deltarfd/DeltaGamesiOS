//
//  String+Ext.swift
//  DeltaGames
//
//  Created by Delta R.F.D on 05/05/26.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case system
    case english = "en"
    case indonesian = "id"

    var id: String { rawValue }

    var localeIdentifier: String {
        switch self {
        case .system:
            return Locale.autoupdatingCurrent.identifier
        case .english:
            return "en"
        case .indonesian:
            return "id"
        }
    }

    var effectiveLanguageCode: String {
        switch self {
        case .system:
            let preferred = Locale.preferredLanguages.first ?? "en"
            return preferred.lowercased().hasPrefix("id") ? "id" : "en"
        case .english:
            return "en"
        case .indonesian:
            return "id"
        }
    }

    var displayKey: String {
        switch self {
        case .system:
            return "language.system"
        case .english:
            return "language.english"
        case .indonesian:
            return "language.indonesian"
        }
    }
}

enum L10n {
    private static let translations: [String: [String: String]] = [
        "tab.home": ["en": "Home", "id": "Beranda"],
        "tab.search": ["en": "Search", "id": "Cari"],
        "tab.favorite": ["en": "Favorite", "id": "Favorit"],
        "tab.profile": ["en": "Profile", "id": "Profil"],
        "home.greeting": ["en": "Hey", "id": "Hai"],
        "home.subtitle": ["en": "Let's Explore The Games!", "id": "Yuk Jelajahi Game!"],
        "home.new_trending": ["en": "New & Trending", "id": "Baru & Trending"],
        "home.explore_games": ["en": "Explore Games", "id": "Jelajahi Game"],
        "search.title": ["en": "Search Games", "id": "Cari Game"],
        "search.placeholder": ["en": "Search ...", "id": "Cari ..."],
        "search.not_found": ["en": "Game is Not Found", "id": "Game Tidak Ditemukan"],
        "favorite.title": ["en": "Favorite Games", "id": "Game Favorit"],
        "favorite.empty": ["en": "No Favorite Game", "id": "Belum Ada Game Favorit"],
        "detail.released": ["en": "Released:", "id": "Rilis:"],
        "detail.tags": ["en": "Tags:", "id": "Tag:"],
        "detail.description": ["en": "Description", "id": "Deskripsi"],
        "profile.name": ["en": "Name", "id": "Nama"],
        "profile.caption": ["en": "Caption", "id": "Keterangan"],
        "profile.joined_date": ["en": "Joined since 19 Sep 2017", "id": "Bergabung sejak 19 Sep 2017"],
        "profile.language": ["en": "Language", "id": "Bahasa"],
        "language.system": ["en": "System", "id": "Sistem"],
        "language.english": ["en": "English", "id": "Inggris"],
        "language.indonesian": ["en": "Indonesian", "id": "Indonesia"],
        "common.cancel": ["en": "Cancel", "id": "Batal"],
        "common.save": ["en": "Save", "id": "Simpan"],
        "common.edit": ["en": "Edit", "id": "Ubah"]
    ]

    static func text(_ key: String) -> String {
        let selectedLanguage = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "app_language") ?? AppLanguage.system.rawValue) ?? .system
        let code = selectedLanguage.effectiveLanguageCode
        return translations[key]?[code] ?? translations[key]?["en"] ?? key
    }
}

extension String {
    // MARK: - SF Symbols Icons
    enum SFSymbol: String {
        case starFill = "star.fill"
        case heartFill = "heart.circle.fill"
        case heartEmpty = "heart.circle"
        case magnifyingGlass = "magnifyingglass"
        case xmark = "xmark"
        case homeFill = "house.fill"
        case home = "house"
        case heart = "heart"
        case personFill = "person.circle.fill"
        case magnifyingGlassCircleFill = "magnifyingglass.circle.fill"
        case multiplyCircleFill = "multiply.circle.fill"
    }
    
    // MARK: - Asset Image Names
    enum Asset: String {
        case bgProfile = "bg_profile"
        case deltaRfd = "deltarfd"
        case appPrimaryColor = "AppPrimaryColor"
        case accentColor = "AccentColor"
    }
    
    // MARK: - UI String Constants
    enum UIString {
        static let searchPlaceholder = "Search ..."
        static let releasePrefix = "Released: "
        static let tagPrefix = "Tags: "
        static let descriptionTitle = "Description"
        static let joinedDate = "Bergabung sejak 19 Sep 2017"
    }
    
    // MARK: - Error Messages
    enum Error: String {
        case loadingFailed = "Failed to load data"
        case networkError = "Network error occurred"
        case emptyResult = "No results found"
    }
}
