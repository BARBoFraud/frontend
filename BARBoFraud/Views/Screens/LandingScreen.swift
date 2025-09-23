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
            BackgroundView {
                VStack {
                    Spacer()
                    Text("oFraud")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(30)
                        .frame(width: 300)
                        .background(Color("Waves"))
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
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color("Waves"))
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
