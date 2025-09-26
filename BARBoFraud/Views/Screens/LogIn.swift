//
//  LogIn.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct LogIn: View {
    // Call router for programmatic navigation
    @EnvironmentObject var router: Router
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            // Background gradient color
            LinearGradient(colors: [Color.landingBg2, Color.landingBg1], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Background waves
            LandingWaves()
            
            VStack{
                HStack {
                    Spacer()
                    BackArrowBtn()
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
                        
                        // Login button
                        NavigationButton(
                            action: {
                                if (ValidateLogin()) {
                                    router.reset(to: .home)
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
                .background(Color("Tarjeta"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
//        ZStack {
//            // Background gradient color
//            LinearGradient(colors: [Color.landingBg2, Color.landingBg1], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
//            
//            // Background waves
//            LandingWaves()
//            
//            VStack{
//                HStack {
//                    Spacer()
//                    NavigationIcon(
//                        destinationScreen: LandingScreen(),
//                        iconName: "arrow.left",
//                        width: 28,
//                        height: 28,
//                        fgColor: .backArrow
//                    )
//                    Spacer().frame(width: 325)
//                }
//                .padding(.top)
//
//                Spacer()
//                
//                Text("Iniciar Sesión")
//                    .foregroundColor(Color("Text"))
//                    .font(.largeTitle.bold())
//                Spacer()
//                
//                VStack{
//                    Section{
//                        Text("Correo electrónico")
//                            .foregroundColor(Color("Text"))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.system(size: 24))
//                            .padding(.leading)
//                        
//                        TextField("Correo", text: $email)
//                            .frame(height: 49)
//                            .background(.white)
//                            .cornerRadius(19)
//                            .padding(.horizontal)
//                            .autocorrectionDisabled(true)
//                            .textInputAutocapitalization(.never)
//                            .keyboardType(.emailAddress)
//                            .foregroundColor(.black)
//                        
//                        Spacer().frame(height: 20)
//                        
//                        Text("Contraseña")
//                            .foregroundColor(Color("Text"))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.system(size: 24))
//                            .padding(.leading)
//                        
//                        SecureField("Contraseña", text: $password)
//                            .frame(height: 49)
//                            .background(.white)
//                            .cornerRadius(19)
//                            .padding(.horizontal)
//                            .autocorrectionDisabled(true)
//                            .textInputAutocapitalization(.never)
//                            .foregroundColor(.black)
//                        
//                        Spacer().frame(height: 30)
//                        
//                        Button(action: {
//                            print("Login")
//                        }) {
//                            Text("Iniciar Sesión")
//                                .font(.headline)
//                                .foregroundColor(.text)
//                                .padding(.vertical)
//                                .padding(.horizontal, 65)
//                                .background(Color("BtnColor"))
//                                .cornerRadius(12)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .frame(maxWidth: 300, maxHeight: 350)
//                .padding(.vertical, 30)
//                .background(Color("Tarjeta"))
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
//            }
//        }
    }
}





#Preview {
    RootView()
//    LogIn()
//        .environmentObject(Router())
}
