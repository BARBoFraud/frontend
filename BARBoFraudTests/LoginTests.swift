//
//  BARBoFraudTests.swift
//  BARBoFraudTests
//
//  Created by Jorge Cadena on 23/10/25.
//

import XCTest
@testable import BARBoFraud

final class LoginTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoginSuccessful() async {
        let authController = AuthenticationController()
        let request = LoginRequest(
            email: "barbo@barbo.com",
            password: "barbo"
        )
        let response = await authController.loginUser(body: request)
        XCTAssertTrue(response)
    }
    
    func testLoginFailed() async {
        let authController = AuthenticationController()
        let request = LoginRequest(
            email: "barbo@barbo.com",
            password: "Barbo"
        )
        let response = await authController.loginUser(body: request)
        XCTAssertFalse(response)
    }
}
