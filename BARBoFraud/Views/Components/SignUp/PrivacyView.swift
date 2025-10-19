//
//  PrivacyView.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct PrivacyView: View {
    @Binding var accepted: Bool
    let privacyText: String
    
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
        .sheet(isPresented: $showingPrivacySheet) {
            NavigationView {
                ScrollView {
                    Text(privacyText)
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
}





#Preview {
    PrivacyView(accepted: .constant(false), privacyText: "Privacy Text")
        .padding()
}
