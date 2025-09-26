//
//  SignUp.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct SignUp: View {
    @Environment(\.authController) var authController
    
    @State private var acceptedPrivacy = false
    @State private var showResultAlert = false
    private let privacyText = """
        Aviso de privacidad.
        
        KKJBEWFEDIFHCDJFHYRJHJVGCDGDVGVYTYFEHFIH9HIU
        """
    
    @State var registrationForm = UserRegistrationForm()
    @State var errorMessages: [String] = []
    
    @State var navLogin: Bool = false
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    func register() async {
        do {
            try await authController.registerUser(name: registrationForm.name, lastName1: registrationForm.lastNameP, lastName2: registrationForm.lastNameM, email: registrationForm.email, password: registrationForm.password)
            showAlert = true
            alertTitle = "Se ha creado su cuenta exitosamente"
            navLogin = true
        }
        catch {
            showAlert = true
            alertTitle = "Error"
            errorMessages.append("No se ha podido realizar su cuenta")
            print("Error al intentar registrarse")
        }
    }
    
    var body: some View {
        ZStack {
            // Background gradient color
            LinearGradient(colors: [Color.landingBg2, Color.landingBg1], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Background waves
            ReverseLandingWaves()
            LandingWaves()
            
            
            NavigationStack {
                ScrollView(.vertical) {
                    VStack {
                        HStack {
                            Spacer()
                            BackArrowBtn(destination: LandingScreen())
                                .frame(width: 40, height: 40)
                                .bold(true)
                            Spacer().frame(width: 325)
                        }
                        
                        Spacer().frame(height: 30)
                        
                        Text("Crea tu cuenta")
                            .foregroundColor(Color("Text"))
                            .font(.title)
                            .bold()
                        
                        Spacer().frame(height: 40)
                        
                        VStack {
                            Group {
                                Text("Nombre:")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                    .bold()
                                
                                TextField("Nombre:", text: $registrationForm.name)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                
                                
                                Text("Apellido Paterno:")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                    .bold()
                                
                                TextField("Apellido Paterno", text: $registrationForm.lastNameP)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                
                                Text("Apellido Materno:")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                    .bold()
                                
                                TextField("Apellido Materno", text: $registrationForm.lastNameM)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                .foregroundColor(.black)                    }
                            
                            Group {
                                Text("Correo electrónico:")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                    .bold()
                                
                                TextField("Correo", text: $registrationForm.email)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                // .keyboardType(.emailAddress)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                
                                Text("Contraseña:")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                    .bold()
                                
                                SecureField("Contraseña", text: $registrationForm.password)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(.black)
                                
                                Text("Verificar Contraseña:")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                    .bold()
                                
                                SecureField("Verificar Contraseña", text: $registrationForm.passwordConfirmation)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer().frame(height: 10)
                            
                            PrivacyView(accepted: $acceptedPrivacy, privacyText: privacyText)
                            
                            Button {
                                errorMessages = registrationForm.validate()
                                if errorMessages.isEmpty {
                                    if !acceptedPrivacy {
                                        showResultAlert = true
                                    } else {
                                        Task {
                                            await register()
                                            print("signed up")
                                        }
                                    }
                                }
                            } label: {
                                Text("Crear cuenta")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color("BlueAccent"))
                                    .cornerRadius(12)
                            }
                            
                            NavigationLink(destination: LogIn().navigationBarBackButtonHidden(true), isActive: $navLogin) {
                                EmptyView()
                            }
                        
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: 300)
                        .padding(.vertical, 30)
                        .background(Color("Tarjeta"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Spacer().frame(height: 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 30)
                }
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
        .alert(isPresented: $showResultAlert) {
            Alert(title: Text("Aviso"), message: Text("Debes aceptar el aviso de privacidad"), dismissButton: .default(Text("OK")))
        }
    }
}


#Preview {
    NavigationStack {
        SignUp()
    }
}
