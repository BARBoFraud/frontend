//
//  HomeScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            NavigationBar()
            Text("Home")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
