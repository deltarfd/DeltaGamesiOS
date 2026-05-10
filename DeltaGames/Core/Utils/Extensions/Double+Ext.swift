//
//  Double+Ext.swift
//  DeltaGames
//
//  Created by Delta R.F.D on 05/05/26.
//

import Foundation

extension Double {
    /// Formats a rating value to 2 decimal places with "/5" suffix
    /// - Returns: Formatted string (e.g., "4.52/5")
    func formatted(maxRating: Int = 5) -> String {
        String(format: "%.2f/%d", self, maxRating)
    }
    
    /// Formats a rating value to 2 decimal places without suffix
    /// - Returns: Formatted string (e.g., "4.52")
    func formattedRatingOnly() -> String {
        String(format: "%.2f", self)
    }
}

extension Optional where Wrapped == Double {
    /// Safely formats an optional rating value with a placeholder if nil
    /// - Returns: Formatted string (e.g., "4.52/5" or "N/A")
    func formattedRating(maxRating: Int = 5, nilText: String = "N/A") -> String {
        guard let value = self else { return nilText }
        return value.formatted(maxRating: maxRating)
    }
}
