//
//  NewReportButton.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/12.
//

import SwiftUI

struct NewReportButton: View {
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            Spacer()
            HStack() {
                Spacer()
                Button(action: {
                    router.push(.info) // TODO cambiar ruta a crear nuevo reporte
                }){
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(
                            Circle()
                                .fill(.blueAccent)
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        )
                }
                .padding(.trailing, 40)
                .padding(.bottom, 70)
            }
        }
        
    }
}

#Preview {
    NewReportButton()
}
