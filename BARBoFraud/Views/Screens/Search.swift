//
//  SearchScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

import SwiftUI

struct Search: View {
    @StateObject private var vm = SearchViewModel()
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack {
            Color(.appBg)
                .onTapGesture {
                    isInputFocused = false
                }
            SearchWaves()
            
            // Navigation bar positioning
            VStack(spacing: 0) {
                SearchBar(vm: vm)
                    .focused($isInputFocused)
                SearchResult(vm: vm)
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
