//
//  AuthenticationController.swift
//  RegistroUsuario452
//
//  Created by Barbie on 29/08/25.
//

import Foundation

struct AuthenticationController{
    let httpClient:HTTPClient
    func registerUser(name:String, lastName1: String, lastName2: String, email:String, password:String) async throws {
        try await httpClient.UserRegistration(name: name, lastName1: lastName1, lastName2: lastName2, email: email, password: password)
    }
    func loginUser(email:String, password:String) async throws ->  Bool{
        let loginResponse = try await httpClient.UserLogin(email: email, password: password)
        TokenStorage.set(identifier: "accessToken", value: loginResponse.accessToken)
        TokenStorage.set(identifier: "refreshToken", value: loginResponse.refreshToken)
        return loginResponse.accessToken != nil
    }
    
    func logout() async throws {
        try await httpClient.UserLogOut(refreshToken: TokenStorage.get(identifier: "refreshToken")!)
        print("Logout exitoso")
        TokenStorage.delete(identifier: "accessToken")
        TokenStorage.delete(identifier: "refreshToken")
    }
    
    func deactivateUser(password: String) async throws {
        _ = try await ensureAccessToken()

        try await httpClient.DeactivateUser(password: password)
        print( "Usuario desactivado")
        TokenStorage.delete(identifier: "accessToken")
        TokenStorage.delete(identifier: "refreshToken")
    }
    
    func refreshAccessToken() async throws -> String {
           guard let refreshToken = TokenStorage.get(identifier: "refreshToken"),
                 !refreshToken.isEmpty else {
               throw RefreshError.invalidRefreshToken
           }

           let newAccessToken = try await httpClient.refreshAccessToken(refreshToken: refreshToken)
           TokenStorage.set(identifier: "accessToken", value: newAccessToken)
           return newAccessToken
       }

       func ensureAccessToken() async throws -> String {
           if let access = TokenStorage.get(identifier: "accessToken"), !access.isEmpty {
               return access
           } else {
               return try await refreshAccessToken()
           }
       }
}
