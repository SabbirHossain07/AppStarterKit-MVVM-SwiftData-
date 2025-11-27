//
//  CounterViewModel.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import Foundation
import SwiftData
import SwiftUI
import Combine

@MainActor
final class CounterViewModel: ObservableObject {
    @Published var counter: Counter?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadCounter()
    }
    
    // MARK: - CRUD Operations
    
    /// Loads the first counter from the database or creates a new one
    func loadCounter() {
        isLoading = true
        errorMessage = nil
        
        let descriptor = FetchDescriptor<Counter>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            let counters = try modelContext.fetch(descriptor)
            if let existingCounter = counters.first {
                counter = existingCounter
            } else {
                createCounter()
            }
        } catch {
            errorMessage = "Failed to load counter: \(error.localizedDescription)"
            createCounter()
        }
        
        isLoading = false
    }
    
    /// Creates a new counter
    func createCounter() {
        let newCounter = Counter(value: 0, title: "My Counter")
        modelContext.insert(newCounter)
        counter = newCounter
        saveContext()
    }
    
    /// Updates the counter value
    func updateCounter(value: Int) {
        guard let counter = counter else { return }
        counter.value = value
        counter.updatedAt = Date()
        saveContext()
    }
    
    /// Increments the counter
    func increment(by amount: Int = 1) {
        guard let counter = counter else { return }
        counter.increment(by: amount)
        saveContext()
    }
    
    /// Decrements the counter
    func decrement(by amount: Int = 1) {
        guard let counter = counter else { return }
        counter.decrement(by: amount)
        saveContext()
    }
    
    /// Resets the counter to zero
    func reset() {
        guard let counter = counter else { return }
        counter.reset()
        saveContext()
    }
    
    /// Deletes the counter
    func deleteCounter() {
        guard let counter = counter else { return }
        modelContext.delete(counter)
        saveContext()
        self.counter = nil
    }
    
    // MARK: - Private Helpers
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            errorMessage = "Failed to save: \(error.localizedDescription)"
        }
    }
}

