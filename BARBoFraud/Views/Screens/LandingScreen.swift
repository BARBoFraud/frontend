//
//  ContentView.swift
//  wavy_background
//
//  Created by Jorge Cadena on 21/08/25.
//

import SwiftUI

struct LandingScreen: View {
    var body: some View {
        ZStack {
            // Background gradient color
            LinearGradient(colors: [Color.landingBg2, Color.landingBg1],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            // Background waves
            LandingWaves()
            
            VStack {
            Spacer()
            Text("oFraud")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .padding(30)
                .frame(width: 300)
                .background(.landingBg2)
                .cornerRadius(15)
                    
            Spacer()
            
            // Buttons HStack
            HStack(spacing: 20) {
                // Login Button
                Button(action: {
                    print("Login")
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blueAccent)
                        .cornerRadius(12)
                }
                        
                // Signup Button
                Button(action: {
                    print("Signup")
                }) {
                    Text("Signup")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.landingBg2)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    LandingScreen()
}
