//
//  DeactivatePasswordCard.swift
//  BARBoFraud
//
//  Created by Barbie on 13/10/25.
//

import SwiftUI

struct DeactivatePasswordCard: View {
    @Binding var isPresented: Bool

    @State private var password: String = ""
    @State private var isProcessing: Bool = false
    @State private var errorMessage: String? = nil

    @Environment(\.authController) var authController
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @EnvironmentObject var router: Router
    
    private func confirmAction() async {
        // Request body
        let deactivateUserBody = DeactivateRequest(
            password: password
        )
        
        // API call
        let isUserDeactivated = await authController.deactivateUser(body: deactivateUserBody)
        
        // Check if the user was correctly deactivated
        if (!isUserDeactivated) {
            errorMessage = "Error al intentar desactivar la cuenta, verifica la contraseña."
            return
        }
        
        // Go to landing screen
        isLoggedIn = false
        router.clear()
    }

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { isPresented = false }
                    }

                VStack(spacing: 16) {
                    Text("Confirma tu contraseña para desactivar la cuenta")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .padding(.top, 8)

                    SecureField("Contraseña", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(UIColor.systemGray6))
                        )
                        .shadow(radius: 1)

                    HStack(spacing: 12) {
                        Button(action: {
                            withAnimation { isPresented = false }
                        }) {
                            Text("Cancelar")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(UIColor.systemGray5))
                                )
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Button(action: {
                            Task {
                                await confirmAction()
                            }
                        }) {
                            if isProcessing {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                            } else {
                                Text("Desactivar")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                            }
                        }
                        .disabled(isProcessing || password.isEmpty)
                        .buttonStyle(PlainButtonStyle())
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isProcessing || password.isEmpty ? Color(UIColor.systemGray4) : .warningRed)
                        )
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    if let error = errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.warningRed)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }else{
                        Text("")
                            .font(.caption)
                            .foregroundColor(.warningRed)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    Spacer().frame(height: 8)
                }
                .padding(20)
                .frame(maxWidth: 360)
                .background(.postBg)
                .cornerRadius(20)
                .shadow(radius: 4)
                .padding(.horizontal, 20)
                .transition(.scale.combined(with: .opacity))
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isPresented)
            .navigationBarBackButtonHidden(true)

        }
    }
}

struct DeactivatePasswordCard_Previews: PreviewProvider {
    static var previews: some View {
        DeactivatePasswordCard(isPresented: .constant(true))
            .environmentObject(Router())
    }
}
