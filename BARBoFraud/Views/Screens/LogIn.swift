//
//  LogIn.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct LogIn: View {
    @Environment(\.authController) var authController
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State var loginForm = LoginForm()
    @State var errorMessages: [String] = []
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var navInfo: Bool = false
    
    
    private func login() async {
        do {
            let success = try await authController.loginUser(email: loginForm.email, password: loginForm.pass)
            if success {
                showAlert = true
                alertTitle = "Inicio de sesión exitoso"
                isLoggedIn = true
                navInfo = true
            } else {
                showAlert = true
                alertTitle = "Error"
                errorMessages.append("Usuario o contraseña incorrectos")
                
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    var body: some View {
        ZStack {
                // Background gradient color
                LinearGradient(colors: [Color.landingBg2, Color.landingBg1], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                // Background waves
                LandingWaves()
                
            NavigationStack{
                VStack{
                    HStack {
                        Spacer()
                        BackArrowBtn(destination: LandingScreen())
                            .frame(width: 40, height: 40)
                            .bold(true)
                        Spacer().frame(width: 325)
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    Text("Iniciar Sesión")
                        .foregroundColor(Color("Text"))
                        .font(.title.bold())
                    Spacer()
                    
                    VStack{
                        Section{
                            Text("Correo electrónico:")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline.bold())
                            
                            TextField("Correo", text: $loginForm.email)
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.vertical)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .foregroundColor(.black)
                            
                            
                            Text("Contraseña:")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline.bold())
                            
                            SecureField("Contraseña", text: $loginForm.pass)
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.vertical)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .foregroundColor(.black)
                            
                            Spacer().frame(height: 8)
                            
                            Button(action: {
                                errorMessages = loginForm.validate()
                                if errorMessages.isEmpty {
                                    Task {
                                        await login()
                                    }
                                }
                            }) {
                                Text("Iniciar Sesión")
                                    .font(.headline)
                                    .foregroundColor(.text)
                                    .padding()
                                    .background(Color("BtnColor"))
                                    .cornerRadius(12)
                            }
                            
                            NavigationLink(destination: Info().navigationBarBackButtonHidden(true), isActive: $navInfo) {
                                EmptyView()
                            }
                            
                        }
                        .padding(.horizontal)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Aviso"), message: Text(alertTitle))
                        }
                    }
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding(.vertical, 30)
                    .background(Color("Tarjeta"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                if !errorMessages.isEmpty {
                    VStack {
                        ValidationSummary(errors: $errorMessages)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .padding(.top, 60)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .animation(.spring(response: 0.45, dampingFraction: 0.8), value: errorMessages)
                }
            }
        }
    }
}





#Preview {
    NavigationStack {
        LogIn()
    }
}
