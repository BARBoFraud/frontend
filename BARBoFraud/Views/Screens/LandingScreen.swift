//
//  ContentView.swift
//  wavy_background
//
//  Created by Jorge Cadena on 21/08/25.
//

import SwiftUI

struct LandingScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient color
                LinearGradient(colors: [Color.landingBg2, Color.landingBg1], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                // Background waves
                LandingWaves()
                
                VStack {
                    Spacer()
                    // "oFraud" container
                    Text("oFraud")
                        .font(.largeTitle.bold())
                        .foregroundColor(.text)
                        .padding(30)
                        .frame(width: 300)
                        .background(Color("BgText"))
                        .cornerRadius(15)
                    
                    Spacer()
                    // Buttons Container
                    HStack(spacing: 20) {
                        // Login button
                        NavigationButton(
                            destinationScreen: LogIn(),
                            text: "Iniciar Sesión",
                            fgColor: .white,
                            bgColor: .blueAccent
                        )
                        // Signup button
                        NavigationButton(
                            destinationScreen: SignUp(),
                            text: "Registrarse",
                            fgColor: .text,
                            bgColor: .bgText
                        )
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

#Preview {
    LandingScreen()
}
