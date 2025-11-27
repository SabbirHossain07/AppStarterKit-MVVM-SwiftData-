//
//  AppSpacing.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI

struct AppSpacing {
    // Base spacing unit (8pt grid system)
    static let base: CGFloat = 8
    
    // Spacing tokens
    static let xs: CGFloat = base * 0.5      // 4pt
    static let sm: CGFloat = base            // 8pt
    static let md: CGFloat = base * 2        // 16pt
    static let lg: CGFloat = base * 3        // 24pt
    static let xl: CGFloat = base * 4        // 32pt
    static let xxl: CGFloat = base * 6       // 48pt
    static let xxxl: CGFloat = base * 8      // 64pt
    
    // Component-specific spacing
    static let cardPadding: CGFloat = md
    static let screenPadding: CGFloat = md
    static let buttonPadding: CGFloat = sm
    static let sectionSpacing: CGFloat = lg
}

// View extension for easy spacing application
extension View {
    func appPadding(_ spacing: CGFloat) -> some View {
        padding(spacing)
    }
    
    func appPadding(_ edges: Edge.Set = .all, _ spacing: CGFloat) -> some View {
        padding(edges, spacing)
    }
}

