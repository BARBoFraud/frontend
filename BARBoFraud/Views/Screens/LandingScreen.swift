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
                    Text("oFraud")
                        .font(.largeTitle.bold())
                        .foregroundColor(.text)
                        .padding(30)
                        .frame(width: 300)
                        .background(Color("BgText"))
                        .cornerRadius(15)
                    
                    Spacer()
                    HStack(spacing: 20) {
                        NavigationLink(destination: LogIn().navigationBarBackButtonHidden(true)) {
                            Text("Iniciar Sesión")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("BlueAccent"))
                                .cornerRadius(12)
                        }
                        
                        NavigationLink(destination: SignUp().navigationBarBackButtonHidden(true)) {
                            Text("Registrarse")
                                .font(.headline)
                                .foregroundColor(.text)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("BgText"))
                                .cornerRadius(12)
                        }
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
