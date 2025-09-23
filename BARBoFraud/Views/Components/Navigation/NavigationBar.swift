//
//  NavigationBar.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 17/09/25.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var selectedScreen: RootScreen
    
    var body: some View {
        ZStack {
            Color(.navBar)
            HStack {
                Spacer()
                Button {
                    selectedScreen = .info
                } label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.blueAccent)
                }
                Spacer()
                Button {
                    selectedScreen = .home
                } label: {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.blueAccent)
                }
                Spacer()
                Button {
                    selectedScreen = .search
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.blueAccent)
                }
                Spacer()
            }
        }
        .frame(height: 60)
        .offset(y: 392.5)
        .shadow(color: .black, radius: 1)
    }
}
