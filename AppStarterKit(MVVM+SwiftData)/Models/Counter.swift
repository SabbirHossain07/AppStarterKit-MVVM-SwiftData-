//
//  Counter.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import Foundation
import SwiftData

@Model
final class Counter {
    var id: UUID
    var value: Int
    var title: String
    var createdAt: Date
    var updatedAt: Date
    
    init(id: UUID = UUID(), value: Int = 0, title: String = "Counter", createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.value = value
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Counter Extensions
extension Counter {
    /// Increments the counter value
    func increment(by amount: Int = 1) {
        value += amount
        updatedAt = Date()
    }
    
    /// Decrements the counter value
    func decrement(by amount: Int = 1) {
        value -= amount
        updatedAt = Date()
    }
    
    /// Resets the counter to zero
    func reset() {
        value = 0
        updatedAt = Date()
    }
}

