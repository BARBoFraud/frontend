//
//  RootView.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 25/09/25.
//

import SwiftUI

struct RootView: View {
    // Create router for programmatic navigation
    @StateObject var router = Router()
    
    var body: some View {
        // Check router path to change screens
        NavigationStack(path: $router.path) {
            LandingScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .landing: LandingScreen()
                    case .login: LogIn()
                    case .signup: SignUp()
                    case .info: InfoScreen()
                    case .home: HomeScreen()
                    case .search: SearchScreen()
                    }
                }
        }
        .environmentObject(router) // Make router an environment object
    }
}
