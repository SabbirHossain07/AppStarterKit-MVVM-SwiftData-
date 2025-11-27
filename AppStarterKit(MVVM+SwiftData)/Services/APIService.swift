//
//  APIService.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import Foundation

/// Protocol for API service to enable dependency injection and testing
protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ endpoint: String) async -> Result<T, AppError>
    func post<T: Decodable, U: Encodable>(_ endpoint: String, body: U) async -> Result<T, AppError>
}

/// Default API service implementation
class APIService: APIServiceProtocol {
    static let shared = APIService()
    
    private let baseURL: String
    private let session: URLSession
    
    init(baseURL: String = "https://api.example.com", session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    // MARK: - GET Request
    func fetch<T: Decodable>(_ endpoint: String) async -> Result<T, AppError> {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            return .failure(.networkError("Invalid URL"))
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return .failure(.networkError("Invalid response"))
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
            
        } catch let error as DecodingError {
            return .failure(.decodingError(error.localizedDescription))
        } catch {
            return .failure(.networkError(error.localizedDescription))
        }
    }
    
    // MARK: - POST Request
    func post<T: Decodable, U: Encodable>(_ endpoint: String, body: U) async -> Result<T, AppError> {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            return .failure(.networkError("Invalid URL"))
        }
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let bodyData = try encoder.encode(body)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = bodyData
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return .failure(.networkError("Invalid response"))
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(T.self, from: data)
            return .success(decoded)
            
        } catch let error as EncodingError {
            return .failure(.encodingError(error.localizedDescription))
        } catch let error as DecodingError {
            return .failure(.decodingError(error.localizedDescription))
        } catch {
            return .failure(.networkError(error.localizedDescription))
        }
    }
}

