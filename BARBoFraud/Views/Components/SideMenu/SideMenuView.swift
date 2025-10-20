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
    
    @StateObject private var vm = ProfileViewModel()
    
    @State private var isEditing = false
    @State private var showEmptyFieldsAlert = false
    
    @State private var showingLogoutCard = false
    @Environment(\.authController) var authController
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    
    @Environment(\.openURL) var openUrl
    @State private var showingPoliceCard: Bool = false
    let policeNumber = "5611773689"
    
    @State private var showingDeactivateCard: Bool = false
    
    @EnvironmentObject var router: Router
    
    private func loadProfile() async {
        guard let response = await vm.getProfile() else {
            print("Error al cargar el perfil:")
            return
        }
        name = response.name
        lastName2 = response.lastName2
        lastName1 = response.lastName1
        email = response.email
    }
    
    private func callPolice() async {
        guard let url = URL(string: "tel://\(policeNumber)")  else { return }
        openUrl(url)
    }
    
    private func logOutBtnTapped() async throws {
        try await authController.logout()
        isLoggedIn = false
        router.clear()
    }
    
    var body: some View {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer().frame(height: 30)
                    VStack(alignment: .leading, spacing: 2) {
                        HStack {
                            if isEditing {
                                VStack {
                                    TextField("Nombre", text: $name)
                                        .font(.title2)
                                        .foregroundColor(.text)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .textInputAutocapitalization(.never)
                                    TextField("Apellido 1", text: $lastName1)
                                        .font(.title2)
                                        .foregroundColor(.text)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .textInputAutocapitalization(.never)
                                }
                            } else {
                                Text(name)
                                    .font(.title2)
                                    .foregroundColor(.text)
                                Text(lastName1)
                                    .font(.title2)
                                    .foregroundColor(.text.opacity(0.7))
                            }
                            Spacer()
                            Image(systemName: isEditing ? "checkmark.circle.fill" : "square.and.pencil.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(isEditing ? .green : .blueAccent)
                                .onTapGesture {
                                    withAnimation(.smooth.speed(5)) {
                                        if isEditing {
                                            let emptyFields = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                            lastName1.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                            lastName2.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                            
                                            if emptyFields {
                                                showEmptyFieldsAlert = true
                                                return
                                            }
                                            
                                            Task {
                                                let updatedProfile = UpdateProfile(
                                                    name: name,
                                                    lastName1: lastName1,
                                                    lastName2: lastName2,
                                                    email: email
                                                )
                                                
                                                await vm.updateProfile(updatedProfile)
                                            }
                                        }
                                        isEditing.toggle()
                                    }
                                }
                        }
                        if isEditing {
                            TextField("Correo electrónico", text: $email)
                                .foregroundColor(.text)
                                .font(.title3)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textInputAutocapitalization(.never)
                        } else {
                            Text(verbatim: "\(email)")
                                .foregroundColor(.text.opacity(0.5))
                                .font(.title3)
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal)
                    .alert("Campos vacíos", isPresented: $showEmptyFieldsAlert) {
                        Button("Ok", role: .cancel) {}
                    }
                    
                    Rectangle()
                        .fill(.black.opacity(0.7))
                        .frame(height: 2, alignment: .leading)
                    
                    
                    Group {
                        SideMenuItem(icon: "clock.arrow.circlepath", label: "Historial de reportes") {
                            router.push(.history)
                        }
                        SideMenuItem(icon: "gearshape.fill", label: "Configuraciones") {}
                        SideMenuItem(icon: "chart.pie.fill", label: "Estadísticas") {router.push(.charts)}
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
                    
                    HStack{
                        Spacer()
                        Text("Desactivar cuenta")
                            .foregroundColor(.warningRed)
                            .font(.headline.bold())
                            .onTapGesture {
                                showingDeactivateCard = true
                            }
                            .navigationBarBackButtonHidden(true)
                        Spacer()
                    }
                    .padding(.bottom, 40)
                }
                .frame(width: 300, alignment: .leading)
                .background(.appBg)
                .ignoresSafeArea(.keyboard)
                .edgesIgnoringSafeArea(.top)
                
                if showingLogoutCard {
                    ConfirmationCard(isPresented: $showingLogoutCard, title: "¿Seguro que deseas cerrar sesión?", confirmAction: {
                        do {
                            try await logOutBtnTapped()
                        } catch {
                            print("Error al cerrar sesion: \(error)")
                        }
                    })
                }
                
                if showingDeactivateCard {
                    DeactivatePasswordCard(isPresented: $showingDeactivateCard)
                }
                
                
                if showingPoliceCard {
                    ConfirmationCard(isPresented: $showingPoliceCard, title: "¿Seguro que deseas contactar con la policía cibernética?", confirmAction: callPolice)
                }

            }
            .task {
                await loadProfile()
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SideMenuView(showMenu: .constant(true))
}
