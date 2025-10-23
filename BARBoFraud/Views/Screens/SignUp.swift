//
//  SignUp.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

enum Field: Hashable{
    case name
    case first_surname
    case second_surname
    case email
    case password
    case verify_password
}

struct SignUp: View {
    @EnvironmentObject var router: Router
    @Environment(\.authController) var authController
    
    @State private var acceptedPrivacy = false
    @State private var showResultAlert = false
    
    private let privacyText = ""
    
    @State var registrationForm = UserRegistrationForm()
    @State var errorMessages: [String] = []
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    @FocusState private var focusedField: Field?
    func register() async {
        do {
            try await authController.registerUser(
                name: registrationForm.name,
                lastName1: registrationForm.lastName1,
                lastName2: registrationForm.lastName2,
                email: registrationForm.email,
                password: registrationForm.password
            )
            
            showAlert = true
            alertTitle = "Se ha creado su cuenta exitosamente"
            router.reset(to: .login)
            
        } catch RegistrationError.emailExists {
            errorMessages.append("El correo ya está registrado")
        } catch {
            errorMessages.append("No se ha podido realizar su cuenta")
            print("Error al intentar registrarse: \(error)")
        }
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
            
            ScrollView(.vertical, showsIndicators: false) {
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
                            .foregroundColor(.text)
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer().frame(height: 40)
                        
                        VStack {
                            Group {
                                Text("Nombre")
                                    .foregroundColor(.text)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Nombre", text: $registrationForm.name)
                                    .focused($focusedField, equals: .name)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.text)
                                    .onSubmit {
                                        focusedField = .first_surname
                                    }
                                
                                Text("Apellido Paterno")
                                    .foregroundColor(.text)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Apellido Paterno", text: $registrationForm.lastName1)
                                    .focused($focusedField, equals: .first_surname)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                    .onSubmit {
                                        focusedField = .second_surname
                                    }
                                
                                Text("Apellido Materno")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Apellido Materno", text: $registrationForm.lastName2)
                                    .focused($focusedField, equals: .second_surname)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                    .onSubmit {
                                        focusedField = .email
                                    }

                                Text("Correo electrónico")
                                    .foregroundColor(.text)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                TextField("Correo", text: $registrationForm.email)
                                    .focused($focusedField, equals: .email)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .padding(.vertical)
                                    .foregroundColor(.black)
                                    .onSubmit {
                                        focusedField = .password
                                    }
                                
                                Text("Contraseña")
                                    .foregroundColor(.text)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                SecureField("Contraseña", text: $registrationForm.password)
                                    .focused($focusedField, equals: .password)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(.black)
                                    .textContentType(.none)
                                    .onSubmit {
                                        focusedField = .verify_password
                                    }
                                
                                Text("Verificar Contraseña")
                                    .foregroundColor(Color("Text"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                    .bold()
                                
                                SecureField("Verificar Contraseña", text: $registrationForm.passwordConfirmation)
                                    .focused($focusedField, equals: .verify_password)
                                    .padding(.vertical, 6)
                                    .padding(.leading, 10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .padding(.vertical)
                                    .autocorrectionDisabled(true)
                                    .foregroundColor(.black)
                                    .textContentType(.none)
                            }
                            
                            Spacer().frame(height: 10)
                            
                            Group {
                                PrivacyView(accepted: $acceptedPrivacy)
                                    .padding(.bottom, 20)
                                
                                NavigationButton(
                                    action: {
                                        errorMessages = registrationForm.validate()
                                        if errorMessages.isEmpty {
                                            if !acceptedPrivacy {
                                                showResultAlert = true
                                            } else {
                                                Task {
                                                    await register()
                                                }
                                            }
                                        }
                                    },
                                    text: "Crear cuenta",
                                    fgColor: .text,
                                    bgColor: .blueAccent
                                )
                                Spacer().frame(height: 15)
                                
                                NavigationButton(
                                    action: {
                                        router.reset(to: .login)
                                    },
                                    text: "¿Ya tienes cuenta?",
                                    fgColor: .text,
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
                    .padding(.bottom, 30)
            }.ignoresSafeArea(.keyboard, edges: .bottom)
                .onAppear(){
                    focusedField = .name
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
    }
}


#Preview {
    RootView()
}
