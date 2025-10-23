//
//  LogIn.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct LogIn: View {
    @EnvironmentObject var router: Router
        
    @Environment(\.authController) var authController
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    @State var loginForm = LoginForm()
    @State var errorMessages: [String] = []
    
    @FocusState private var focusedField: Field?
    private func login() async {
        // Create the body of the request
        let loginBody = LoginRequest(
            email: loginForm.email,
            password: loginForm.pass
        )
        
        // Make the call to the API
        let response = await authController.loginUser(body: loginBody)
        
        // Validate the response
        if (!response) {
            errorMessages.append("Credenciales inválidas. Inténtalo de nuevo")
            return
        }
        
        // Make the login
        isLoggedIn = true
        router.reset(to: .home)
    }
    
    
    var body: some View {
        ZStack {
                ZStack {
                    LinearGradient(colors: [Color.landingBg2, Color.landingBg1],
                                   startPoint: .top, endPoint: .bottom)
                    ReverseLandingWaves()
                    LandingWaves()
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)

                VStack{
                    HStack {
                        Spacer()
                        BackArrowBtn()
                            .frame(width: 40, height: 40)
                            .bold(true)
                        Spacer().frame(width: 325)
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    Text("Iniciar Sesión")
                        .foregroundColor(Color("Text"))
                        .font(.largeTitle.bold())
                    Spacer()
                    
                    VStack{
                        Section{
                            Text("Correo electrónico")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3.bold())
                            
                            TextField("Correo", text: $loginForm.email)
                                .focused($focusedField, equals: .email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .padding(.vertical, 6)
                                .padding(.leading, 10)
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.vertical)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .foregroundColor(.black)
                                .onSubmit {
                                    focusedField = .password
                                }
                            
                             
                            Text("Contraseña")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title3.bold())
                            
                            SecureField("Contraseña", text: $loginForm.pass)
                                .focused($focusedField, equals: .password)
                                .padding(.vertical, 6)
                                .padding(.leading, 10)
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.vertical)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.none)
                                .foregroundColor(.black)
                                .onSubmit {
                                    Task{
                                        do{
                                            try await tryLogin()
                                        }catch{
                                            print(error)
                                        }
                                    }
                                }
                            
                            Spacer().frame(height: 8)
                            
                            NavigationButton(
                                action: {
                                    Task{
                                        do{
                                            try await tryLogin()
                                        }catch{
                                            print(error)
                                        }
                                    }
                                },
                                text: "Iniciar Sesión",
                                fgColor: .text,
                                bgColor: .btn
                            )
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding(.vertical, 30)
                    .background(.tarjeta)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }.ignoresSafeArea(.keyboard, edges: .bottom)

            
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
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.async {
                focusedField = .email
            }
        }
    }
    
    func tryLogin() async throws {
        errorMessages = loginForm.validate()
        if errorMessages.isEmpty {
            Task {
                await login()
            }
        }
    }
}





#Preview {
    LogIn()
}
