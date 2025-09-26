//
//  NavigationButton.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 23/09/25.
//

import SwiftUI

struct NavigationButton: View {
    // Call router for programmatic navigation
    @EnvironmentObject var router: Router
    
    let action: () -> Void
    let text: String
    let fgColor: Color
    let bgColor: Color
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .foregroundColor(fgColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(bgColor)
                .cornerRadius(12)
        }
    }
}

#Preview {
    NavigationButton(action: {print("Barbo")}, text: "Iniciar sesión", fgColor: .white, bgColor: .blueAccent)
}
