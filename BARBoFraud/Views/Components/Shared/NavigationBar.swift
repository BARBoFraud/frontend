//
//  NavigationBar.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 17/09/25.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        ZStack {
            Color(.navBar)
            HStack {
                Spacer()
                NavigationIcon(
                    route: .info,
                    iconName: "info.circle",
                    width: 32,
                    height: 32,
                    fgColor: .blueAccent
                )
                Spacer()
                NavigationIcon(
                    route: .home,
                    iconName: "house",
                    width: 32,
                    height: 32,
                    fgColor: .blueAccent
                )
                Spacer()
                NavigationIcon(
                    route: .search,
                    iconName: "magnifyingglass",
                    width: 32,
                    height: 32,
                    fgColor: .blueAccent
                )
                Spacer()
            }
        }
        .frame(height: 60)
        .shadow(color: .black, radius: 1)
    }
}

#Preview {
    RootView()
}
