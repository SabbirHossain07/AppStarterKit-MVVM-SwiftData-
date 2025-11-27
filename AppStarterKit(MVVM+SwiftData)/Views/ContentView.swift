//
//  ContentView.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            CounterView(modelContext: modelContext)
                .navigationTitle("App Starter Kit")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Counter.self, configurations: config)
    
    return ContentView()
        .modelContainer(container)
}
