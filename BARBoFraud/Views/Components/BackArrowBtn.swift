//
//  BackArrowBtn.swift
//  oFraud_Equipo8
//
//  Created by Barbie on 22/09/25.
//

import SwiftUI

struct BackArrowBtn<Destination: View>: View {
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination.navigationBarBackButtonHidden(true)) {
            Image(systemName: "arrow.left")
                .frame(width: 60, height: 60)
                .foregroundColor(.primary)
        }
    }
}
