//
//  BackArrowBtn.swift
//  oFraud_Equipo8
//
//  Created by Usuario on 22/09/25.
//

import SwiftUI

struct BackArrowBtn<Destination: View>: View {
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
            Image(systemName: "arrow.left")
                .foregroundColor(.primary)
                .frame(width: 60, height: 60)
        }
    }
}
