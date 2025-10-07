//
//  InfoScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

import SwiftUI

struct Info: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                NavigationBar()
            }
            .edgesIgnoringSafeArea(.bottom)
            Text("Info")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
