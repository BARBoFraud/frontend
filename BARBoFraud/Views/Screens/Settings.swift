//
//  Settings.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/10/25.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var darkModeManager: DarkModeManager
    @EnvironmentObject var router: Router
    var body: some View {
        VStack{
            ViewHeader(title: "Configuración")
            Toggle(isOn: $darkModeManager.isDarkMode) {
                Label("Modo oscuro", systemImage: darkModeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
            }.padding()
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(.appBg)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
