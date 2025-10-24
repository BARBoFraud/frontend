//
//  RegisterClient.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/10/25.
//

extension NetworkManager {
    // Register
    func UserRegistration(body: RegistrationFormRequest) async throws {
        try await request(
            "/users/register",
            method: "POST",
            body: body
        )
    }
    
    // Login
    func UserLogin(body: LoginRequest) async throws -> LoginResponse {
        return try await request(
            "/auth/users/login",
            method: "POST",
            body: body
        )
    }
    
    // Logout
    func UserLogOut(body: LogOutRequest) async throws {
        try await request(
            "/auth/users/logout",
            method: "POST",
            body: body
        )
    }
    
    // Deactivate account
    func DeactivateUser(body: DeactivateRequest) async throws {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        
        try await request(
            "/users/deactivate",
            method: "PATCH",
            token: token,
            body: body
        )
    }
    
    // Refresh access token
    func RefreshAccessToken() async throws -> RefreshResponse {
        guard let refreshToken = TokenStorage.get(identifier: "refreshToken"), !refreshToken.isEmpty else {
            throw NetworkError.noRefreshToken
        }
        
        let body = RefreshRequest(
            refreshToken: refreshToken
        )
        
        return try await request(
            "/auth/users/refresh",
            method: "POST",
            body: body
        )
    }
}
