//
//  NetworkErrors.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 06/10/25.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noInternet
    case requestFailed(Int)
    case noToken
    case noRefreshToken
    case unauthorized // Error 401
    case notFound // Error 404
    case invalidToken // Error 409
    case decodingFailed
    case noData
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noInternet:
            return "No internet connection. Please try again later."
        case .noToken:
            return "No token was found."
        case .noRefreshToken:
            return "No refresh token was found."
        case .unauthorized:
            return "You are not authorized. Please log in again."
        case .notFound:
            return "Not found."
        case .invalidToken:
            return "The token found was invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .decodingFailed:
            return "Failed to decode the response from the server."
        case .noData:
            return "No data was received from the server."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
