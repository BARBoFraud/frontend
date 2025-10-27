//
//  SearchTests.swift
//  Tests
//
//  Created by Jorge Cadena on 24/10/25.
//

import Testing
@testable import BARBoFraud

struct SearchTests {

    // Created by Leonardo Pérez
    @Test func testSearchSuccessful() async throws {
        let authController = AuthenticationController()
        
        let loginBody = LoginRequest(email: "correo.pruebas@existente.com", password: "Password123.")
        let _ = await authController.loginUser(body: loginBody)
        
        let vm = await SearchViewModel()
        await vm.search(query: "robado")
        
        #expect(await vm.results.isEmpty == false)

    }
    
    // Created by Leonardo Pérez
    @Test func testSearchFailed() async throws {
        let authController = AuthenticationController()
        
        let _ = await authController.logout(body: LogOutRequest(refreshToken: TokenStorage.get(identifier: "refreshToken") ?? ""))
        TokenStorage.delete(identifier: "accessToken")
        TokenStorage.delete(identifier: "refreshToken")
        
        let vm = await SearchViewModel()
        let _ = await vm.search(query: "Filantropo")
        
        #expect(await vm.results.isEmpty == true)
    }
}
