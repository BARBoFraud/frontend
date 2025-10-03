//
//  SideMenuView.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    let width = 300
    
    @State private var name: String = ""
    @State private var lastName2: String = ""
    @State private var lastName1: String = ""
    @State private var email: String = ""
    
    @State private var navLanging: Bool = false
    
    @State private var showingLogoutCard = false
    @Environment(\.authController) var authController
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    
    @Environment(\.openURL) var openUrl
    @State private var showingPoliceCard: Bool = false
    let policeNumber = "5611773689"
    
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
    
    private func callPolice() async {
        guard let url = URL(string: "tel://\(policeNumber)")  else { return }
        openUrl(url)
    }
    
    private func logOutBtnTapped() async throws {
        try await authController.logout()
        isLoggedIn = false
        navLanging = true
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                        SideMenuItem(icon: "phone.fill", label: "Contacto ciber policía") {
                            showingPoliceCard = true
                        }
                        SideMenuItem(icon: "iphone.and.arrow.forward", label: "Cerrar sesión") {
                            showingLogoutCard = true
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                }
                .frame(width: 300, height: UIScreen.main.bounds.height, alignment: .leading)
                .background(.appBg)
                .edgesIgnoringSafeArea(.vertical)
                
                if showingLogoutCard {
                    ConfirmationCard(isPresented: $showingLogoutCard, title: "¿Seguro que deseas cerrar sesión?", confirmAction: logOutBtnTapped)
                }
                NavigationLink(destination: LandingScreen().navigationBarBackButtonHidden(true), isActive: $navLanging) {
                    EmptyView()
                }
                
                if showingPoliceCard {
                    ConfirmationCard(isPresented: $showingPoliceCard, title: "¿Seguro que deseas contactar con la policía cibernética?", confirmAction: callPolice)
                }

            }
            .task {
                await loadProfile()
            }
        }
    }
}

#Preview {
    SideMenuView(showMenu: .constant(true))
}
