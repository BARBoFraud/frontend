//
//  SideMenuItem.swift
//  BARBoFraud
//
//  Created by Usuario on 23/09/25.
//

import SwiftUI

struct SideMenuItem: View {
    var icon: String
    var label: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.black.opacity(0.7))
                    .frame(width: 24)
                
                Text(label)
                    .foregroundColor(.text)
            }
        }
    }
}

#Preview {
    SideMenuItem(icon: "clock.arrow.circlepath", label: "Historial de reportes") {}
        .background(Color.secondary)
}
