//
//  Result+Extensions.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import Foundation

// Custom error type for app-wide error handling
enum AppError: LocalizedError {
    case networkError(String)
    case decodingError(String)
    case encodingError(String)
    case persistenceError(String)
    case validationError(String)
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "Network Error: \(message)"
        case .decodingError(let message):
            return "Decoding Error: \(message)"
        case .encodingError(let message):
            return "Encoding Error: \(message)"
        case .persistenceError(let message):
            return "Persistence Error: \(message)"
        case .validationError(let message):
            return "Validation Error: \(message)"
        case .unknownError(let message):
            return "Unknown Error: \(message)"
        }
    }
}

// Result type extensions for easier error handling
extension Result {
    /// Maps the success value using the provided closure
    func mapSuccess<NewSuccess>(_ transform: (Success) -> NewSuccess) -> Result<NewSuccess, Failure> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    /// Maps the failure value using the provided closure
    func mapFailure<NewFailure>(_ transform: (Failure) -> NewFailure) -> Result<Success, NewFailure> {
        switch self {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .failure(transform(error))
        }
    }
}

// Note: Use Result.success(value) and Result.failure(error) directly
// Example: Result<String, AppError>.success("Hello")
//          Result<String, AppError>.failure(.networkError("Failed"))

