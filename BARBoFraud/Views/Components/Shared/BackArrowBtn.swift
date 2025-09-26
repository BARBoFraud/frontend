//
//  BackArrowBtn.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct BackArrowBtn: View {
    // Call router for programmatic navigation
    @EnvironmentObject var router: Router
    
    var body: some View {
        Button(action: {
            router.pop()
        }) {
            Image(systemName: "arrow.left")
                .resizable()
                .foregroundColor(.primary)
                .frame(width: 35, height: 35)
        }
    }
}
