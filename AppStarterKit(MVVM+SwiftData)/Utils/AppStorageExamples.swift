//
//  AppStorageExamples.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI

/// Example view demonstrating AppStorage usage
struct AppStorageExamplesView: View {
    // String AppStorage
    @AppStorage("userName") private var userName: String = "Guest"
    
    // Integer AppStorage
    @AppStorage("userAge") private var userAge: Int = 0
    
    // Boolean AppStorage
    @AppStorage("isNotificationsEnabled") private var isNotificationsEnabled: Bool = true
    
    // Double AppStorage
    @AppStorage("userRating") private var userRating: Double = 0.0
    
    // Enum AppStorage (using RawValue)
    @AppStorage("appTheme") private var appTheme: String = AppTheme.system.rawValue
    
    var body: some View {
        Form {
            Section("User Preferences") {
                TextField("User Name", text: $userName)
                Stepper("Age: \(userAge)", value: $userAge, in: 0...120)
                Toggle("Notifications", isOn: $isNotificationsEnabled)
                Slider(value: $userRating, in: 0...5, step: 0.1) {
                    Text("Rating: \(userRating, specifier: "%.1f")")
                }
            }
            
            Section("App Settings") {
                Picker("Theme", selection: $appTheme) {
                    ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                        Text(theme.displayName).tag(theme.rawValue)
                    }
                }
            }
            
            Section("Current Values") {
                Text("Name: \(userName)")
                Text("Age: \(userAge)")
                Text("Notifications: \(isNotificationsEnabled ? "On" : "Off")")
                Text("Rating: \(userRating, specifier: "%.1f")")
                Text("Theme: \(AppTheme(rawValue: appTheme)?.displayName ?? "Unknown")")
            }
        }
        .navigationTitle("AppStorage Examples")
    }
}

// MARK: - AppTheme Enum
enum AppTheme: String, CaseIterable {
    case system = "system"
    case light = "light"
    case dark = "dark"
    
    var displayName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}

