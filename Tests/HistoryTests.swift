//
//  HistoryTests.swift
//  Tests
//
//  Created by Jorge Cadena on 23/10/25.
//

import Testing
@testable import BARBoFraud

struct HistoryTests {

    // Created by Jorge Cadena
    @Test func TestCategorySuccessful() async {
        let authController = AuthenticationController()
        
        let loginBody = LoginRequest(email: "correo.pruebas@existente.com", password: "Password123.")
        let _ = await authController.loginUser(body: loginBody)
        
        let vm = await HistoryViewModel()
        let categoryId = await vm.getCategoryId("Llamada")
        
        #expect(categoryId > 0)
    }
    
    // Created by Jorge Cadena
    @Test func TestCategoryFailed() async {
        let authController = AuthenticationController()
        
        let loginBody = LoginRequest(email: "correo.pruebas@existente.com", password: "Password123.")
        let _ = await authController.loginUser(body: loginBody)
        
        let vm = await HistoryViewModel()
        let categoryId = await vm.getCategoryId("Categoría inexistente")
        
        #expect(categoryId == 0)
    }

}
