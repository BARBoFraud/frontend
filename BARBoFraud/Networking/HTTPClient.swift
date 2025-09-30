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

struct HTTPClient {
    
    func UserRegistration(name:String, lastName1:String, lastName2:String,email:String, password:String) async throws {
        let requestForm = RegistrationFormRequest(name:name, lastName1: lastName1, lastName2: lastName2,email:email, password:password)
        let url = URL(string: "http://10.48.235.0:3000/v1/users/register")!
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
        //let url = URL(string: "http://localhost:3000/auth/login")!
        guard let url = URL(string: "http://10.48.235.0:3000/v1/auth/users/login") else {
            fatalError("Invalid URL" + "http://localhost:3000/auth/users/login")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginRequest)
        let (data, response) = try await URLSession.shared.data(for:urlRequest)
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        return loginResponse
    }
    
    
}
