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
        do {
            try await authController.deactivateUser(password: password)
            withAnimation {
                isPresented = false
            }
            isLoggedIn = false
            router.push(.landing)
        } catch let err as DeactivateUserError {
        switch err {
            case .invalidPassword:
                errorMessage = "La contraseña es incorrecta."
            default:
                errorMessage = "Ocurrió un error. Intenta más tarde."
            }
        }
        catch {
            errorMessage = "Ocurrió un error. Intenta más tarde."
            print("Error al desactivar la cuenta: \(error)")
        }
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
                        .padding(.horizontal)

                    if let error = errorMessage {
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

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
                                .fill(isProcessing || password.isEmpty ? Color(UIColor.systemGray4) : Color.red)
                        )
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    Spacer().frame(height: 8)
                }
                .padding(20)
                .frame(maxWidth: 360)
                .background(.ultraThinMaterial)
                .cornerRadius(14)
                .shadow(radius: 20)
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
