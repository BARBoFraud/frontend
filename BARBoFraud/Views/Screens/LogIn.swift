//
//  LogIn.swift
//  oFraud_Equipo8
//
//  Created by Usuario on 22/09/25.
//

import SwiftUI

struct LogIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        BackgroundView {
            
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
                            .font(.headline.bold())
                        
                        SecureField("Contraseña", text: $password)
                            .background(.white)
                            .cornerRadius(10)
                            .padding()
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(.black)
                        
                        Spacer().frame(height: 8)
                        
                        Button(action: {
                            print("Login")
                        }) {
                            Text("Iniciar Sesión")
                                .font(.headline)
                                .foregroundColor(.text)
                                .padding()
                                .background(Color("BtnColor"))
                                .cornerRadius(12)
                        }
                        
                    }
                    .padding(.horizontal)
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
        }
    }
}





#Preview {
    NavigationStack {
        LogIn()
    }
}
