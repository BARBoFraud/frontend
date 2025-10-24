//
//  LoginTests.swift
//  Tests
//
//  Created by Jorge Cadena on 23/10/25.
//

import Testing
@testable import BARBoFraud

struct LoginTests {

    // Created by Esteban Hernández
    @Test func testLoginSuccessful() async {
        let authController = AuthenticationController()
        let body = LoginRequest(email:"correo.pruebas@existente.com" , password: "Password123.")
        
        let response = await authController.loginUser(body: body)
        #expect(response == true)
    }
    
    // Created by Esteban Hernández
    @Test func testLoginFailed() async {
        let authController = AuthenticationController()
        let body = LoginRequest(email: "correo.pruebas@inexistente.com", password: "Password123.")
        
        let response = await authController.loginUser(body: body)
        #expect(response == false)
    }

}
