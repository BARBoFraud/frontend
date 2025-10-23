//
//  PrivacyView.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct PrivacyView: View {
    @Binding var accepted: Bool
    @State var privacyNotice: String = ""
    
    @State private var showingPrivacySheet = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Button(action: {
                withAnimation {
                    accepted.toggle()
                }
            }) {
                Image(systemName: accepted ? "checkmark.square.fill" : "square")
                    .font(.title2)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text("Acepto el")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        showingPrivacySheet = true
                    }) {
                        Text("Aviso de privacidad")
                            .font(.subheadline)
                            .underline()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Text("Debes aceptar el aviso de privacidad para crear tu cuenta.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .onAppear(){
            getPrivacyNotice()
        }
        .sheet(isPresented: $showingPrivacySheet) {
            NavigationView {
                ScrollView {
                    Text(privacyNotice)
                        .font(.subheadline)
                        .padding()
                        .multilineTextAlignment(.leading)
                }
                .navigationTitle("Aviso de Privacidad")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Cerrar") {
                            showingPrivacySheet = false
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    func getPrivacyNotice(){
        if let path = Bundle.main.path(forResource: "Aviso", ofType: "txt") {
            privacyNotice = (try? String(contentsOfFile: path, encoding: .utf8)) ?? "No se pudo cargar el aviso de privacidad."
        }
    }
}





#Preview {
    PrivacyView(accepted: .constant(false))
        .padding()
}
