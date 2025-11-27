//
//  Extensions.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI
import Foundation

#if canImport(UIKit)
import UIKit
#endif

// MARK: - View Extensions
extension View {
    /// Applies corner radius to specific corners
    #if canImport(UIKit)
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    #endif
    
    /// Hides keyboard when tapped outside
    #if canImport(UIKit)
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    #endif
}

// MARK: - RoundedCorner Shape
#if canImport(UIKit)
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
#endif

// MARK: - String Extensions
extension String {
    /// Checks if string is a valid email
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    /// Trims whitespace and newlines
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Checks if string is empty or contains only whitespace
    var isBlank: Bool {
        trimmed.isEmpty
    }
}

// MARK: - Date Extensions
extension Date {
    /// Formats date to string
    func formatted(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    /// Formats date and time to string
    func formatted(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
}

// MARK: - Array Extensions
extension Array {
    /// Safely access array element at index
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// MARK: - Optional Extensions
extension Optional where Wrapped == String {
    /// Returns empty string if nil
    var orEmpty: String {
        self ?? ""
    }
}

extension Optional {
    /// Executes closure if value is not nil
    func `if`(_ closure: (Wrapped) -> Void) {
        if let value = self {
            closure(value)
        }
    }
}

