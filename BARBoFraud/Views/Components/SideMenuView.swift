//
//  SideMenuView.swift
//  BARBoFraud
//
//  Created by Usuario on 23/09/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool
    let width = 300
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Spacer().frame(height: 30)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Quevedo el mejor")
                        .font(.title2)
                        .foregroundColor(.text)
                    
                    Text(verbatim: "quevedito@tec.mx")
                        .foregroundColor(.text.opacity(0.5))
                        .font(.title3)
                        
                }
                .padding(.top, 40)
                .padding(.horizontal)

                Rectangle()
                    .fill(.black.opacity(0.7))
                    .frame(height: 2)
                    .frame(width: .infinity, alignment: .leading)

                
                Group {
                    SideMenuItem(icon: "clock.arrow.circlepath", label: "Historial de reportes") {}
                    SideMenuItem(icon: "gearshape.fill", label: "Configuraciones") {}
                }
                .padding(.horizontal)
                
                Rectangle()
                    .fill(.black.opacity(0.7))
                    .frame(height: 2)
                    .frame(width: .infinity, alignment: .leading)

                
                Group {
                    SideMenuItem(icon: "phone.fill", label: "Contacto ciber policía") {}
                    SideMenuItem(icon: "iphone.and.arrow.forward", label: "Cerrar sesión") {}
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .frame(width: 300, height: UIScreen.main.bounds.height, alignment: .leading)
            .background(.appBg)
            .edgesIgnoringSafeArea(.vertical)
    }
}

#Preview {
    SideMenuView(showMenu: .constant(true))
}
