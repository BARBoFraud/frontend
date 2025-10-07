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
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(.blueAccent)
                    .clipShape(Circle())
                    .shadow(radius: 4)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Hay \(errors.count) error(es)")
                        .font(.headline)
                        .foregroundColor(Color("Text"))
                    Text("Revisa los campos marcados.")
                        .font(.subheadline)
                        .foregroundColor(Color("Text").opacity(0.8))
                }

                Spacer()

                Button {
                    withAnimation {
                        errors.removeAll()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("Text"))
                        .padding(8)
                }
            }

            Divider()
                .background(Color.gray.opacity(0.3))

            VStack(alignment: .leading, spacing: 8) {
                ForEach(errors, id: \.self) { err in
                    HStack(alignment: .top, spacing: 8) {
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(.blueAccent)
                            .padding(.top, 6)

                        Text(err)
                            .font(.subheadline)
                            .foregroundColor(Color("Text"))
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: 320)
        .background(Color("Tarjeta"))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.25), radius: 12, x: 0, y: 6)
    }
}

struct ValidationSummary_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ValidationSummary(errors: .constant([
                "El nombre es requerido",
                "El correo no es válido",
                "Las contraseñas no coinciden"
            ]))
        }
    }
}

