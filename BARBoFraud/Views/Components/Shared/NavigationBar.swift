//
//  NavigationBar.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 17/09/25.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationIcon(
                route: .info,
                iconName: "info.circle",
                width: 29,
                height: 29,
                fgColor: .backArrow
            )
            Spacer()
            NavigationIcon(
                route: .home,
                iconName: "house",
                width: 29,
                height: 29,
                fgColor: .backArrow
            )
            Spacer()
            NavigationIcon(
                route: .search,
                iconName: "magnifyingglass",
                width: 29,
                height: 29,
                fgColor: .backArrow
            )
            Spacer()
        }
        .frame(height: 70)
        .background(.ultraThinMaterial)
        //.background(.navBar)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
        .padding()
    }
}

#Preview {
    NavigationBar()
}
