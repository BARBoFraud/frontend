//
//  NavigationIcon.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 23/09/25.
//

import SwiftUI

struct NavigationIcon: View {
    // Call router for programmatic navigation
    @EnvironmentObject var router: Router
    
    let route: Route
    let iconName: String
    let width: CGFloat
    let height: CGFloat
    let fgColor: Color
    
    var body: some View {
        Button(action: {
            router.reset(to: route)
        }) {
            Image(systemName: iconName)
                .resizable()
                .frame(width: width, height: height)
                .foregroundStyle(fgColor)
        }
    }
}

#Preview {
    NavigationIcon(route: .home, iconName: "house", width: 32, height: 32, fgColor: .blueAccent)
}
