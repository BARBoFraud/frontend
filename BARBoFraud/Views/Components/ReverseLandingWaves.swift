//
//  ReverseLandingWaves.swift
//  BARBoFraud
//
//  Created by Usuario on 22/09/25.
//

import SwiftUI

struct ReverseLandingWaves: View {
    var body: some View {
        ZStack {
            // Custom wave 1
            CustomWaveShape(phase: 2, strength: 30)
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
            
            

            // Custom wave 2
            CustomWaveShape(phase: 3, strength: 40)
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
    ReverseLandingWaves()
}
