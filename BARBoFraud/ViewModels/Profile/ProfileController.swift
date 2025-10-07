//
//  ProfileController.swift
//  RegistroUsuario452
//
//  Created by Barbie on 12/09/25.
//

@MainActor

struct ProfileController{
    private let client = ProfileClient()
    
    func getProfile() async throws -> Profile {
        let profileResponse = try await client.userProfileNet()
        return profileResponse
    }
}
