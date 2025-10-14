//
//  SearchScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

import SwiftUI

struct Search: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Color(.appBg)
            SearchWaves()
            
            // Navigation bar positioning
            VStack(spacing: 0) {
                SearchBar()
                Spacer()
                NavigationBar()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Search()
}
