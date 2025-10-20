//
//  ProfileClient.swift
//  RegistroUsuario452
//
//  Created by Barbie on 12/09/25.
//
import Foundation

extension NetworkManager {
    func userProfileNet() async throws -> Profile {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        
        return try await request("/users/profile", token: token)
    }
    
    func updateProfile(_ body: UpdateProfile) async throws {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        
        return try await request("/users/update", method: "PATCH", token: token, body: body)
    }
}

