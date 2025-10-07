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
        VStack (spacing: 0){
            TopBar()
            FeedView()
            NavigationBar()
                .frame(height: 0)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
