//
//  HTTPClient.swift
//  RegistroUsuario452
//
//  Created by Barbie on 29/08/25.
//

import Foundation

enum RegistrationError: Error {
    case emailExists
    case serverError(statusCode: Int)
}

enum LoginError: Error {
    case invalidCredentials
    case serverError(statusCode: Int)
}

enum LogOutError: Error {
    case serverError(statusCode: Int)
    case invalidToken
}

enum DeactivateUserError: Error {
    case serverError(statusCode: Int)
    case invalidJWT
    case userNotFound
    case missingToken
}

struct HTTPClient {
    
    let baseURL = AppConfig.apiBaseUrl
    
    func UserRegistration(name:String, lastName1:String, lastName2:String,email:String, password:String) async throws {
        let requestForm = RegistrationFormRequest(name:name, lastName1: lastName1, lastName2: lastName2,email:email, password:password)
        guard let url = URL(string: "\(baseURL)/users/register") else {
            fatalError("Invalid URL" + "http://localhost:3000/v1/users/register")
        }
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try JSONEncoder().encode(requestForm)
        httpRequest.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: httpRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
            case 201:
                print("Usuario registrado correctamente")
                return
            case 409:
                throw RegistrationError.emailExists
            default:
                throw RegistrationError.serverError(statusCode: httpResponse.statusCode)
            }

    }
    func UserLogin(email:String, password:String) async throws -> LoginResponse{
        let loginRequest = LoginRequest(email:email, password:password)
        guard let url = URL(string: "\(baseURL)/auth/users/login") else {
            fatalError("Invalid URL" + "http://localhost:3000/auth/users/login")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)
        let (data, response) = try await URLSession.shared.data(for:urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            fatalError("Invalid HTTP response")
        }
        
        switch httpResponse.statusCode {
            case 201:
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                return loginResponse
            case 401:
                throw LoginError.invalidCredentials
            default :
                throw LoginError.serverError(statusCode: httpResponse.statusCode)
            
        }
    }
    
    func UserLogOut(refreshToken: String) async throws {
        let logoutRequest = LogOutRequest(refreshToken: refreshToken)
        guard let url = URL(string: "\(baseURL)/auth/users/logout") else {
            fatalError("Invalid URL" + "http://10.48.234.109:3000/v1/auth/users/logout")
        }
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "POST"
        httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try JSONEncoder().encode(logoutRequest)
        httpRequest.httpBody = jsonData
        let (_, response) = try await URLSession.shared.data(for: httpRequest)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
            case 201:
                return
            case 401:
                throw LogOutError.invalidToken
            default:
                throw LogOutError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    func DeactivateUser() async throws {
        guard let url = URL(string: "\(baseURL)/users/deactivate") else {
            fatalError("Invalid URL" + "http://10.48.234.109:3000/v1/auth/users/deactivate")
        }
        
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw DeactivateUserError.missingToken
        }
        
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "PATCH"
        httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: httpRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200:
            print("Se ha desactivado la cuenta del usuario")
            return
        case 401:
            throw DeactivateUserError.invalidJWT
        case 404:
            throw DeactivateUserError.userNotFound
        default:
            throw URLError(.badServerResponse)
        }
    }
    
}
