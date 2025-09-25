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
    
    @State private var name = ""
    @State private var lastNameP = ""
    @State private var lastNameM = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirmation = ""
    @State private var acceptedPrivacy = false
    @State private var showResultAlert = false
    private let privacyText = """
        Aviso de privacidad.
        
        KKJBEWFEDIFHCDJFHYRJHJVGCDGDVGVYTYFEHFIH9HIU
        """
    
    var body: some View {
        ZStack {
            // Background gradient color
            LinearGradient(colors: [Color.landingBg2, Color.landingBg1], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Background waves
            ReverseLandingWaves()
            LandingWaves()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Spacer()
                        BackArrowBtn()
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
                            
                            TextField("Nombre:", text: $name)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                                .foregroundColor(.black)
                            
                            
                            Text("Apellido Paterno:")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .bold()
                            
                            TextField("Apellido Paterno", text: $lastNameP)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                                .foregroundColor(.black)
                            
                            Text("Apellido Materno:")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .bold()
                            
                            TextField("Apellido Materno", text: $lastNameM)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                                .foregroundColor(.black)                    }
                        
                        Group {
                            Text("Correo electrónico:")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .bold()
                            
                            TextField("Correo", text: $email)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .foregroundColor(.black)
                            
                            Text("Contraseña:")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .bold()
                            
                            SecureField("Contraseña", text: $password)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                                .autocorrectionDisabled(true)
                                .foregroundColor(.black)
                            
                            Text("Verificar Contraseña:")
                                .foregroundColor(Color("Text"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .bold()
                            
                            SecureField("Verificar Contraseña", text: $passwordConfirmation)
                                .background(.white)
                                .cornerRadius(10)
                                .padding()
                                .autocorrectionDisabled(true)
                                .foregroundColor(.black)
                        }
                        
                        Spacer().frame(height: 10)
                        
                        PrivacyView(accepted: $acceptedPrivacy, privacyText: privacyText)
                        
                        // "Crear cuenta" button
                        NavigationButton(
                            action: {
                                guard acceptedPrivacy else {
                                    showResultAlert = true
                                    return
                                }
                                router.push(.login)
                            },
                            text: "Crear cuenta",
                            fgColor: .white,
                            bgColor: .blueAccent
                        )
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
        
        .alert(isPresented: $showResultAlert) {
            Alert(title: Text("Aviso"), message: Text("Debes aceptar el aviso de privacidad"), dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
