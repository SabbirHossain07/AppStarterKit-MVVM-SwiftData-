//
//  AppEnvironment.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI

// MARK: - Environment Keys
struct APIServiceKey: EnvironmentKey {
    static let defaultValue: APIServiceProtocol = APIService.shared
}

struct PersistenceControllerKey: EnvironmentKey {
    static let defaultValue: PersistenceController = PersistenceController.shared
}

// MARK: - Environment Values Extension
extension EnvironmentValues {
    var apiService: APIServiceProtocol {
        get { self[APIServiceKey.self] }
        set { self[APIServiceKey.self] = newValue }
    }
    
    var persistenceController: PersistenceController {
        get { self[PersistenceControllerKey.self] }
        set { self[PersistenceControllerKey.self] = newValue }
    }
}

// MARK: - View Extension for Dependency Injection
extension View {
    func inject(apiService: APIServiceProtocol) -> some View {
        environment(\.apiService, apiService)
    }
    
    func inject(persistenceController: PersistenceController) -> some View {
        environment(\.persistenceController, persistenceController)
    }
}

