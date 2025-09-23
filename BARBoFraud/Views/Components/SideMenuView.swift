//
//  SideMenuView.swift
//  BARBoFraud
//
//  Created by Usuario on 23/09/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Spacer().frame(height: 30)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Quevedo el mejor")
                        .font(.headline)
                        .foregroundColor(.text)
                    
                    Text("quevedito@tec.mx")
                        .font(.caption)
                        .foregroundColor(.text)
                }
                .padding(.top, 40)
                
                Rectangle()
                    .fill(.text)
                    .frame(height: 2)
                    .padding(.horizontal, 15)

                
                Group {
                    SideMenuItem(icon: "clock.arrow.circlepath", label: "Historial de reportes") {}
                    SideMenuItem(icon: "gearshape.fill", label: "Configuraciones") {}
                }
                
                Rectangle()
                    .fill(.text)
                    .frame(height: 2)
                    .padding(.horizontal, 15)

                
                Group {
                    SideMenuItem(icon: "phone.fill", label: "Contacto ciber policía") {}
                    SideMenuItem(icon: "xmark.octagon", label: "Cerrar sesión") {}
                }
                
                Spacer()
            }
            .padding(.leading)
            .frame(width: 250, height: UIScreen.main.bounds.height, alignment: .leading)
            .background(.appBg.opacity(0.95))
            .edgesIgnoringSafeArea(.vertical)
    }
}

#Preview {
    SideMenuView(showMenu: .constant(true))
}
