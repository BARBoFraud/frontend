//
//  NetworkManager.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 06/10/25.
//
import Foundation

// Core Network Manager logic
final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    // API base URL
    private let baseUrl = AppConfig.apiBaseUrl
    
    struct EmptyResponse: Decodable {}
    
    func request<Response: Decodable, Body: Encodable>(
        // Request parameters
        _ endpoint: String,
        method: String = "GET",
        token: String? = nil,
        body: Body? = nil
    ) async throws -> Response {
        // Full URL
        guard let url = URL(string: "http://localhost:4000/v1" + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Check if the JWT is being received
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Check if the request body is being received
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check if the API sends data
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            
            // Map networking erorrs
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.requestFailed(httpResponse.statusCode)
            }
            
            // Decode the response
            do {
                return try JSONDecoder().decode(Response.self, from: data)
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
    
    func request<Response: Decodable>(
        _ endpoint: String,
        method: String = "GET",
        token: String? = nil
    ) async throws -> Response {
        try await request(endpoint, method: method, token: token, body: Optional<Data>.none)
    }
    
    func request(
        _ endpoint: String,
        token: String? = nil
    ) async throws {
        let _: EmptyResponse = try await request(
            endpoint,
            method: "POST",
            token: token,
            body: Optional<Data>.none
        )
    }
    
    func request<Body: Encodable>(
        _ endpoint: String,
        method: String = "GET",
        token: String? = nil,
        body: Body? = nil
    ) async throws {
        let _: EmptyResponse = try await request(
            endpoint,
            method: method,
            token: token,
            body: body
        )
    }
}
