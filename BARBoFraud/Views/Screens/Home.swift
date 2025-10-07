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
        ZStack(alignment: .bottom){
            VStack(spacing: 0){
                //TopBarView()
                FeedView()
            }
            NavigationBar()
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#Preview {
    RootView()
}
