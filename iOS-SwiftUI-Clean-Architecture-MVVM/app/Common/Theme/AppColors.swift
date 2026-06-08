//
//  AppColors.swift
//  iOS-SwiftUI-Clean-Architecture-MVVM
//
//  Modern Color Palette
//

import SwiftUI

struct AppColors {
    // Primary Colors - Vibrant and Modern
    static let primary = Color(hex: "6C5CE7")        // Vibrant Purple
    static let secondary = Color(hex: "00B894")      // Fresh Mint Green
    static let accent = Color(hex: "FD79A8")         // Soft Pink

    // Background Colors
    static let background = Color(hex: "F8F9FA")     // Light Gray Background
    static let cardBackground = Color.white
    static let darkBackground = Color(hex: "2D3436") // Dark Gray

    // Tab Bar Colors
    static let tabBarBackground = Color.white
    static let tabBarSelected = Color(hex: "6C5CE7")
    static let tabBarUnselected = Color(hex: "B2BEC3")

    // Text Colors
    static let textPrimary = Color(hex: "2D3436")
    static let textSecondary = Color(hex: "636E72")
    static let textLight = Color(hex: "B2BEC3")

    // UI Element Colors
    static let success = Color(hex: "00B894")
    static let warning = Color(hex: "FDCB6E")
    static let error = Color(hex: "FF7675")
    static let info = Color(hex: "74B9FF")

    // Gradient Colors
    static let gradientStart = Color(hex: "6C5CE7")
    static let gradientEnd = Color(hex: "A29BFE")
}

// Helper extension to create colors from hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
