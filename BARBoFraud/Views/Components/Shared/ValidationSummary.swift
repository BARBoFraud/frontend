//
//  ValidationSummary.swift
//  RegistroUsuario452
//
//  Created by Barbie on 22/08/25.
//

import SwiftUI

struct ValidationSummary: View {
    
    @Binding var errors: [String]
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)

                VStack(alignment: .leading, spacing: 2) {
                    let errorText = errors.count == 1 ? "error" : "errores"
                    Text("Hay \(errors.count) \(errorText)")
                        .font(.headline)
                        .foregroundColor(Color("Text"))
                    Text("Revisa los campos marcados.")
                        .font(.subheadline)
                        .foregroundColor(.text)
                }
                Spacer()
            }

            Divider()
                .background(.blueAccent)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(errors, id: \.self) { err in
                    HStack(alignment: .top, spacing: 8) {
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(.black)
                            .padding(.top, 6)

                        Text(err)
                            .font(.subheadline)
                            .foregroundColor(.text)
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: 320)
        .background(Color("Tarjeta"))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 6)
    }
}

struct ValidationSummary_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ValidationSummary(errors: .constant([
                "El nombre es requerido.",
                "El correo no es válido.",
                "Las contraseñas no coinciden."
            ]))
        }
    }
}


/*
 withAnimation {
     errors.removeAll()
 }
 */
