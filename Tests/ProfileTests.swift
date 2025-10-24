//
//  ProfileTests.swift
//  Tests
//
//  Created by Jorge Cadena on 23/10/25.
//

import Testing
@testable import BARBoFraud

struct ProfileTests {

    // Created by Leonardo Pérez
    @Test func testProfileSuccessful() async {
        let authController = AuthenticationController()
        
        let loginBody = LoginRequest(email: "correo.pruebas@existente.com", password: "Password123.")
        let _ = await authController.loginUser(body: loginBody)
        
        let vm = await ProfileViewModel()
        guard let _ = await vm.getProfile() else {
            Issue.record("Expected response but got nil instead.")
            return
        }
    }
    
    // Created by Leonardo Pérez
    @Test func testProfileFailed() async {
        let authController = AuthenticationController()
        
        let _ = await authController.logout(body: LogOutRequest(refreshToken: TokenStorage.get(identifier: "refreshToken") ?? ""))
        TokenStorage.delete(identifier: "accessToken")
        TokenStorage.delete(identifier: "refreshToken")

        let vm = await ProfileViewModel()
        let profile = await vm.getProfile()
        
        #expect(profile == nil, "Expected nil profile when not authenticated")
    }
}
