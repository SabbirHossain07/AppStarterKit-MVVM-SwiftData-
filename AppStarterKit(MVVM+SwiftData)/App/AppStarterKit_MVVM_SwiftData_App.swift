//
//  AppStarterKit_MVVM_SwiftData_App.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI
import SwiftData

@main
struct AppStarterKit_MVVM_SwiftData_App: App {
    // Initialize persistence controller
    let persistenceController = PersistenceController.shared
    
    // Initialize dependencies for DI
    let apiService: APIServiceProtocol = APIService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(persistenceController.container)
                .inject(apiService: apiService)
                .inject(persistenceController: persistenceController)
        }
    }
}
