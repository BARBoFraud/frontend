//
//  BackgroundView.swift
//  oFraud_Equipo8
//
//  Created by Usuario on 22/09/25.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Background gradient color
            LinearGradient(colors: [Color.landingBg2, Color.landingBg1],startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            // Background waves
            LandingWaves()
            
            content
        }
    }
}





#Preview {
    BackgroundView{
        VStack{}
    }
}
