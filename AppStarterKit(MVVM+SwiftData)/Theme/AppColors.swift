//
//  AppColors.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI

struct AppColors {
    // Primary Colors
    static let primary = Color("Primary", bundle: nil)
    static let primaryLight = Color("PrimaryLight", bundle: nil)
    static let primaryDark = Color("PrimaryDark", bundle: nil)
    
    // Secondary Colors
    static let secondary = Color("Secondary", bundle: nil)
    static let secondaryLight = Color("SecondaryLight", bundle: nil)
    static let secondaryDark = Color("SecondaryDark", bundle: nil)
    
    // Semantic Colors
    static let background = Color("Background", bundle: nil)
    static let surface = Color("Surface", bundle: nil)
    static let error = Color("Error", bundle: nil)
    static let success = Color("Success", bundle: nil)
    static let warning = Color("Warning", bundle: nil)
    static let info = Color("Info", bundle: nil)
    
    // Text Colors
    static let textPrimary = Color("TextPrimary", bundle: nil)
    static let textSecondary = Color("TextSecondary", bundle: nil)
    static let textTertiary = Color("TextTertiary", bundle: nil)
    
    // Default implementation using system colors
    static func initialize() {
        // These would typically be defined in Assets.xcassets
        // For now, we'll use system colors as fallback
    }
}

// Extension to provide default colors if not in Assets
extension AppColors {
    static var defaultPrimary: Color { .blue }
    static var defaultSecondary: Color { .purple }
    static var defaultBackground: Color { .systemBackground }
    static var defaultSurface: Color { .secondarySystemBackground }
    static var defaultError: Color { .red }
    static var defaultSuccess: Color { .green }
    static var defaultWarning: Color { .orange }
    static var defaultInfo: Color { .blue }
    static var defaultTextPrimary: Color { .primary }
    static var defaultTextSecondary: Color { .secondary }
    static var defaultTextTertiary: Color { .tertiaryLabel }
}

#if canImport(UIKit)
import UIKit
extension Color {
    static var systemBackground: Color {
        Color(uiColor: .systemBackground)
    }
    
    static var secondarySystemBackground: Color {
        Color(uiColor: .secondarySystemBackground)
    }
    
    static var tertiaryLabel: Color {
        Color(uiColor: .tertiaryLabel)
    }
}
#endif

