//
//  WaveBackground.swift
//  wavy_background
//
//  Created by Jorge Cadena on 22/08/25.
//

import SwiftUI

struct LandingWaves: View {
    var body: some View {
        ZStack {
            // Custom wave 1
            CustomWaveShape(phase: 0, strength: 50)
                .fill(
                    LinearGradient(
                        colors: [.wavesTop, .wavesBottom],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 500)
                .offset(y: 170)

            // Custom wave 2
            CustomWaveShape(phase: .pi / 2, strength: 40)
                .fill(
                    LinearGradient(
                        colors: [.wavesTop, .wavesBottom.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 400)
                .offset(y: 250)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LandingWaves()
}
