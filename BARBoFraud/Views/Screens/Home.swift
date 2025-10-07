//
//  HomeScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                NavigationBar()
            }
            .edgesIgnoringSafeArea(.bottom)
            Text("Home")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
