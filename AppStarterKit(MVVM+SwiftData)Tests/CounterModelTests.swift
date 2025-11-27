//
//  CounterModelTests.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import XCTest

final class CounterModelTests: XCTestCase {
    
    func testCounterInitialization() {
        // Given & When: A counter is created with default values
        let counter = Counter()
        
        // Then: It should have default values
        XCTAssertEqual(counter.value, 0, "Default value should be 0")
        XCTAssertEqual(counter.title, "Counter", "Default title should be 'Counter'")
        XCTAssertNotNil(counter.id, "Counter should have a UUID")
        XCTAssertNotNil(counter.createdAt, "Counter should have a creation date")
        XCTAssertNotNil(counter.updatedAt, "Counter should have an update date")
    }
    
    func testCounterCustomInitialization() {
        // Given: Custom values
        let customValue = 42
        let customTitle = "My Custom Counter"
        let customId = UUID()
        let customDate = Date()
        
        // When: A counter is created with custom values
        let counter = Counter(
            id: customId,
            value: customValue,
            title: customTitle,
            createdAt: customDate,
            updatedAt: customDate
        )
        
        // Then: It should have the custom values
        XCTAssertEqual(counter.value, customValue)
        XCTAssertEqual(counter.title, customTitle)
        XCTAssertEqual(counter.id, customId)
        XCTAssertEqual(counter.createdAt, customDate)
        XCTAssertEqual(counter.updatedAt, customDate)
    }
    
    func testIncrement() {
        // Given: A counter with initial value
        let counter = Counter(value: 5)
        let initialValue = counter.value
        
        // When: Increment is called
        counter.increment()
        
        // Then: Value should increase by 1
        XCTAssertEqual(counter.value, initialValue + 1, "Counter should increment by 1")
        XCTAssertNotEqual(counter.updatedAt, counter.createdAt, "Updated date should change")
    }
    
    func testIncrementByAmount() {
        // Given: A counter with initial value
        let counter = Counter(value: 10)
        let incrementAmount = 5
        
        // When: Increment by amount is called
        counter.increment(by: incrementAmount)
        
        // Then: Value should increase by the amount
        XCTAssertEqual(counter.value, 15, "Counter should increment by specified amount")
    }
    
    func testDecrement() {
        // Given: A counter with initial value
        let counter = Counter(value: 10)
        
        // When: Decrement is called
        counter.decrement()
        
        // Then: Value should decrease by 1
        XCTAssertEqual(counter.value, 9, "Counter should decrement by 1")
    }
    
    func testDecrementByAmount() {
        // Given: A counter with initial value
        let counter = Counter(value: 10)
        let decrementAmount = 3
        
        // When: Decrement by amount is called
        counter.decrement(by: decrementAmount)
        
        // Then: Value should decrease by the amount
        XCTAssertEqual(counter.value, 7, "Counter should decrement by specified amount")
    }
    
    func testReset() {
        // Given: A counter with a value
        let counter = Counter(value: 42)
        
        // When: Reset is called
        counter.reset()
        
        // Then: Value should be 0
        XCTAssertEqual(counter.value, 0, "Counter should reset to 0")
    }
}

