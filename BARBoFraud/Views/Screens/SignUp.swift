//
//  SignUp.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct SignUp: View {
    // Call router for programmatic navigation
    @EnvironmentObject var router: Router
    @Environment(\.authController) var authController
    
    @State private var acceptedPrivacy = false
    @State private var showResultAlert = false
    
    private let privacyText = """
        Aviso de privacidad.
        
        KKJBEWFEDIFHCDJFHYRJHJVGCDGDVGVYTYFEHFIH9HIU
        """
    
    @State var registrationForm = UserRegistrationForm()
    @State var errorMessages: [String] = []
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    @FocusState private var isInputFocused: Bool
    func register() async {
        let registrationFormDto = RegistrationFormRequest(
            name: registrationForm.name,
            lastName1: registrationForm.lastName1,
            lastName2: registrationForm.lastName2,
            email: registrationForm.email,
            password: registrationForm.password
        )
        do {
            try await authController.registerUser(body: registrationFormDto)
            
            showAlert = true
            alertTitle = "Se ha creado su cuenta exitosamente"
            router.reset(to: .login)
            
        } catch NetworkError.invalidToken {
            errorMessages.append("El correo ya está registrado")
        } catch {
            errorMessages.append("No se ha podido realizar su cuenta")
            print("Error al intentar registrarse: \(error)")
        }
    }


    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.landingBg2, Color.landingBg1], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ReverseLandingWaves()
            LandingWaves()
            
                ScrollView(.vertical) {
                    VStack {
                        HStack {
                            Spacer()
                            BackArrowBtn()
                                .frame(width: 40, height: 40)
                                .bold(true)
                            Spacer().frame(width: 325)
                        }
                        
                        Spacer().frame(height: 30)
                        
                        Text("Crea tu cuenta")
                            .foregroundColor(Color("Text"))
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer().frame(height: 40)
                        
                        VStack {
                            Group {
                                Text("Nombre")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Nombre", text: $registrationForm.name)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                
                                
                                Text("Apellido Paterno")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Apellido Paterno", text: $registrationForm.lastName1)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                
                                Text("Apellido Materno")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Apellido Materno", text: $registrationForm.lastName2)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                            }
                            
                            Group {
                                Text("Correo electrónico")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Correo", text: $registrationForm.email)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                
                                Text("Contraseña")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                SecureField("Contraseña", text: $registrationForm.password)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(.black)
                                
                                Text("Verificar Contraseña")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                SecureField("Verificar Contraseña", text: $registrationForm.passwordConfirmation)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer().frame(height: 10)
                            
                            Group {
                                PrivacyView(accepted: $acceptedPrivacy, privacyText: privacyText)
                                
                                NavigationButton(
                                    action: {
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
                                    },
                                    text: "Crear cuenta",
                                    fgColor: .white,
                                    bgColor: .blueAccent
                                )
                                Spacer().frame(height: 15)
                                
                                NavigationButton(
                                    action: {
                                        router.reset(to: .login)
                                    },
                                    text: "¿Ya tienes cuenta?",
                                    fgColor: .blueAccent,
                                    bgColor: .tarjeta
                                )
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
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            isInputFocused = false
        }
        .onAppear {
            DispatchQueue.main.async {
                isInputFocused = true
            }
        }
    }
}


#Preview {
    RootView()
}
