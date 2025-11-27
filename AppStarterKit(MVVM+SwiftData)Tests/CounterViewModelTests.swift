//
//  CounterViewModelTests.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import XCTest
import SwiftData

@MainActor
final class CounterViewModelTests: XCTestCase {
    var modelContext: ModelContext!
    var container: ModelContainer!
    var viewModel: CounterViewModel!
    
    override func setUp() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Counter.self, configurations: config)
        modelContext = container.mainContext
        viewModel = CounterViewModel(modelContext: modelContext)
    }
    
    override func tearDown() async throws {
        viewModel = nil
        modelContext = nil
        container = nil
    }
    
    func testInitialCounterCreation() async throws {
        // Given: A new view model
        // When: View model is initialized
        // Then: A counter should be created
        XCTAssertNotNil(viewModel.counter, "Counter should be created on initialization")
        XCTAssertEqual(viewModel.counter?.value, 0, "Initial counter value should be 0")
    }
    
    func testIncrement() async throws {
        // Given: A counter with initial value
        let initialValue = viewModel.counter?.value ?? 0
        
        // When: Increment is called
        viewModel.increment()
        
        // Then: Value should increase by 1
        XCTAssertEqual(viewModel.counter?.value, initialValue + 1, "Counter should increment by 1")
    }
    
    func testIncrementByAmount() async throws {
        // Given: A counter with initial value
        let initialValue = viewModel.counter?.value ?? 0
        let incrementAmount = 5
        
        // When: Increment by amount is called
        viewModel.increment(by: incrementAmount)
        
        // Then: Value should increase by the amount
        XCTAssertEqual(viewModel.counter?.value, initialValue + incrementAmount, "Counter should increment by specified amount")
    }
    
    func testDecrement() async throws {
        // Given: A counter with initial value
        viewModel.increment(by: 5)
        let initialValue = viewModel.counter?.value ?? 0
        
        // When: Decrement is called
        viewModel.decrement()
        
        // Then: Value should decrease by 1
        XCTAssertEqual(viewModel.counter?.value, initialValue - 1, "Counter should decrement by 1")
    }
    
    func testReset() async throws {
        // Given: A counter with a value
        viewModel.increment(by: 10)
        
        // When: Reset is called
        viewModel.reset()
        
        // Then: Value should be 0
        XCTAssertEqual(viewModel.counter?.value, 0, "Counter should reset to 0")
    }
    
    func testUpdateCounter() async throws {
        // Given: A counter
        let newValue = 42
        
        // When: Update counter is called
        viewModel.updateCounter(value: newValue)
        
        // Then: Value should be updated
        XCTAssertEqual(viewModel.counter?.value, newValue, "Counter value should be updated")
    }
}

