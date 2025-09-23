//
//  SearchScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 17/09/25.
//

import SwiftUI

struct RootView: View {
    @State private var selectedScreen: RootScreen = .home
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.landingBg1)
                    .ignoresSafeArea()
                switch selectedScreen {
                case .info:
                    InfoScreen()
                case .home:
                    HomeScreen()
                case .search:
                    SearchScreen()
                }
                    
                
                NavigationBar(selectedScreen: $selectedScreen)
            }
        }
    }
}

#Preview {
    RootView()
}
