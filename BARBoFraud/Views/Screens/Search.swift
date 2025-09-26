//
//  SearchScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

import SwiftUI

struct Search: View {
    var body: some View {
        ZStack {
            NavigationBar()
            Text("Search")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
