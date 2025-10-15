//
//  ProfileController.swift
//  RegistroUsuario452
//
//  Created by Barbie on 12/09/25.
//

@MainActor

struct ProfileController{
    private let client = ProfileClient()
    private let authController = AuthenticationController(httpClient: HTTPClient())
    
    func getProfile() async throws -> Profile {
        _ = try await authController.ensureAccessToken()

        let profileResponse = try await client.userProfileNet()
        return profileResponse
    }
}
