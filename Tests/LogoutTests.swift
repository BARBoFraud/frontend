//
//  LogoutTests.swift
//  Tests
//
//  Created by Jorge Cadena on 23/10/25.
//

import Testing
@testable import BARBoFraud

struct LogoutTests {

    // Created by Diego Herrera
    @Test func testLogoutSuccessful() async {
        let authController = AuthenticationController()
        
        let loginBody = LoginRequest(email: "correo.pruebas@existente.com", password: "Password123.")
        let _ = await authController.loginUser(body: loginBody)
        
        guard let refreshToken = TokenStorage.get(identifier: "refreshToken"), !refreshToken.isEmpty else {
            Issue.record("Expected success but got no refresh token.")
            return
        }
        
        let logoutBody = LogOutRequest(refreshToken: refreshToken)
        let request = await authController.logout(body: logoutBody)
        
        #expect(request == true)
    }
    
    // Created by Diego Herrera
    @Test func testLogoutFailed() async {
        let authController = AuthenticationController()
        
        let loginBody = LoginRequest(email: "correo.pruebas@existente.com", password: "Password123.")
        let _ = await authController.loginUser(body: loginBody)
        
        let refreshToken = ""
        
        let logoutBody = LogOutRequest(refreshToken: refreshToken)
        let request = await authController.logout(body: logoutBody)
        
        #expect(request == false)
    }

}
