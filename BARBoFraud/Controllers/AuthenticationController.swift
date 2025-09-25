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
}
