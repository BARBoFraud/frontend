//
//  AppWaves.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 21/09/25.
//

import SwiftUI

struct AppWaves: View {
    var body: some View {
        ZStack {
            CustomWaveShape(phase: 5, strength: 40)
                .fill(
                    LinearGradient(
                        colors: [.wavesTop, .wavesBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .rotationEffect(.degrees(180))
                .frame(height: 500)
                .offset(y: -300)
            
            CustomWaveShape(phase: .pi / 2, strength: 30)
                .fill(
                    LinearGradient(
                        colors: [.wavesTop, .wavesBottom.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .rotationEffect(.degrees(180))
                .frame(height: 400)
                .offset(y: -320)
        }
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

#Preview {
    AppWaves()
}
