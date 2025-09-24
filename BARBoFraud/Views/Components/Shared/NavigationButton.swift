//
//  NavigationButton.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 23/09/25.
//

import SwiftUI

struct NavigationButton<Destination: View>: View {
    let destinationScreen: Destination
    let text: String
    let fgColor: Color
    let bgColor: Color
    
    var body: some View {
        NavigationLink(destination: destinationScreen.navigationBarBackButtonHidden(true)) {
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
    NavigationButton(destinationScreen: LogIn(), text: "Iniciar sesión", fgColor: .white, bgColor: .blueAccent)
}
