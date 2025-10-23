//
//  ContentView.swift
//  wavy_background
//
//  Created by Jorge Cadena on 21/08/25.
//

import SwiftUI

struct Landing: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.landingBg2,.landingBg1], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LandingWaves()
            
            VStack {
                Spacer()
                Text("oFraud")
                    .font(.largeTitle.bold())
                    .foregroundColor(.text)
                    .padding(30)
                    .frame(width: 300)
                    .background(.landingBg1)
                    .cornerRadius(15)
                
                Spacer()
                HStack(spacing: 20) {
                    NavigationButton(
                        action: {
                            router.push(.login)
                        },
                        text: "Iniciar Sesión",
                        fgColor: .white,
                        bgColor: .blueAccent
                    )
                    NavigationButton(
                        action: {
                            router.push(.signup)
                        },
                        text: "Registrarse",
                        fgColor: .text,
                        bgColor: .landingBg1
                    )
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
