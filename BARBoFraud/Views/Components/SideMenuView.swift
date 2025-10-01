//
//  SideMenuView.swift
//  BARBoFraud
//
//  Created by Usuario on 23/09/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    let width = 300
    
    @State private var name: String = ""
    @State private var lastName2: String = ""
    @State private var lastName1: String = ""
    @State private var email: String = ""
    
    @State private var showingLogoutCard = false
    @Environment(\.authController) var authController
    
    private func loadProfile() async {
        do {
            let response = try await ProfileController().getProfile()
            
            name = response.name
            lastName2 = response.lastName2
            lastName1 = response.lastName1
            email = response.email
        } catch {
            print("Error al cargar el perfil: \(error)")
        }
        
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Spacer().frame(height: 30)
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(name)
                            .font(.title2)
                            .foregroundColor(.text)
                        Text("\(lastName1) \(lastName2)")
                            .font(.title2)
                            .foregroundColor(.text.opacity(0.7))
                    }
                    
                    Text(verbatim: "\(email)")
                        .foregroundColor(.text.opacity(0.5))
                        .font(.title3)
                        
                }
                .padding(.top, 40)
                .padding(.horizontal)

                Rectangle()
                    .fill(.black.opacity(0.7))
                    .frame(height: 2, alignment: .leading)

                
                Group {
                    SideMenuItem(icon: "clock.arrow.circlepath", label: "Historial de reportes") {}
                    SideMenuItem(icon: "gearshape.fill", label: "Configuraciones") {}
                }
                .padding(.horizontal)
                
                Rectangle()
                    .fill(.black.opacity(0.7))
                    .frame(height: 2, alignment: .leading)

                
                Group {
                    SideMenuItem(icon: "phone.fill", label: "Contacto ciber policía") {}
                    SideMenuItem(icon: "iphone.and.arrow.forward", label: "Cerrar sesión") {}
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .frame(width: 300, height: UIScreen.main.bounds.height, alignment: .leading)
            .background(.appBg)
            .edgesIgnoringSafeArea(.vertical)
            .task {
                await loadProfile()
            }
    }
}

#Preview {
    SideMenuView(showMenu: .constant(true))
}
