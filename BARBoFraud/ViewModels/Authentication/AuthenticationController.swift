//
//  AuthenticationController.swift
//  RegistroUsuario452
//
//  Created by Barbie on 29/08/25.
//

import Foundation

struct AuthenticationController{
    // Function to register a new user
    func registerUser(body: RegistrationFormRequest) async throws {
        try await NetworkManager.shared.UserRegistration(body: body)
    }
    
    // Function to call the login of a user
    func loginUser(body: LoginRequest) async -> Bool {
        do {
            let loginResponse = try await NetworkManager.shared.UserLogin(body: body)
            TokenStorage.set(identifier: "accessToken", value: loginResponse.accessToken)
            TokenStorage.set(identifier: "refreshToken", value: loginResponse.refreshToken)
            return true
        } catch {
            print("Error al hacer login: \(error.localizedDescription)")
            return false
        }
    }
    
    // Function to call the logout of a user
    func logout(body: LogOutRequest) async -> Bool {
        do {
            let _ = try await NetworkManager.shared.UserLogOut(body: body)
            TokenStorage.delete(identifier: "accessToken")
            TokenStorage.delete(identifier: "refreshToken")
            return true
        } catch {
            print("Error while logging out: \(error.localizedDescription)")
            return false
        }
    }
    
    // Function to deactivate the user account
    func deactivateUser(body: DeactivateRequest) async -> Bool {
        do {
            // API call to ensure the acces token
            let _ = await ensureAccessToken()
            // API call to deactivate user
            let _ = try await NetworkManager.shared.DeactivateUser(body: body)
            
            // Delete the tokens from the app storage
            TokenStorage.delete(identifier: "accessToken")
            TokenStorage.delete(identifier: "refreshToken")
            
            return true
        } catch {
            print("Error while deactivating user: \(error.localizedDescription)")
            return false
        }
    }
    
    // Function to refresh the access
    func refreshAccessToken() async -> String {
        do {
            let response = try await NetworkManager.shared.RefreshAccessToken()
            return response.accessToken
        } catch {
            print("Error while refreshing access token: \(error.localizedDescription)")
            return ""
        }
    }

    // Function to ensure the access token
    func ensureAccessToken() async -> String {
       if let access = TokenStorage.get(identifier: "accessToken"), !access.isEmpty {
           return access
       } else {
           return await refreshAccessToken()
       }
   }
}
