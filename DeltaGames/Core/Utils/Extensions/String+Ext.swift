//
//  String+Ext.swift
//  DeltaGames
//
//  Created by Delta R.F.D on 05/05/26.
//

import Foundation

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
