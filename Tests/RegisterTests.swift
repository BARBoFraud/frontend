//
//  Tests.swift
//  Tests
//
//  Created by Jorge Cadena on 23/10/25.
//

import Testing
@testable import BARBoFraud

struct RegisterTests {

    // Created by Bárbara Muñoz
    @Test func testRegisterSuccessful() async {
        let authController = AuthenticationController()
        
        let request = RegistrationFormRequest(
            name: "José",
            lastName1: "Vera",
            lastName2: "Aguilar",
            email: "jose.va@gmail.com",
            password: "4rt3.K2lt."
        )
        
        let response = await authController.registerUser(body: request)
        if case .failure(let error) = response {
            Issue.record("Expected success but got failure: \(error)")
        }
    }
    
    // Created by Bárbara Muñoz
    @Test func testRegisterFailed() async {
        let authController = AuthenticationController()
        
        let request = RegistrationFormRequest(
            name: "José",
            lastName1: "Vera",
            lastName2: "Aguilar",
            email: "correo.pruebas@existente.com",
            password: "4rt3.K2lt."
        )
        
        let response = await authController.registerUser(body: request)
        if case .success = response {
            Issue.record("Expected faillure but got success.")
        }
    }

}
