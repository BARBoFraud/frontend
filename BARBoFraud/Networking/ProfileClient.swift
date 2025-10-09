//
//  ProfileClient.swift
//  RegistroUsuario452
//
//  Created by Barbie on 12/09/25.
//
import Foundation

enum ProfileClientError: Error {
    case missingToken
    case invalidURL
    case serverError(String)
}

class ProfileClient {
    func userProfileNet() async throws -> Profile {
        guard let url = URL(string: "http://localhost:4000/v1/users/profile") else {
            throw ProfileClientError.invalidURL
        }

        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw ProfileClientError.missingToken
        }

        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: httpRequest)

        let decoder = JSONDecoder()
        let profile = try decoder.decode(Profile.self, from: data)
        return profile
    }
}

