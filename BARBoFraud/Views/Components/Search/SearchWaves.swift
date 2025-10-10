//
//  WaveBackground.swift
//  wavy_background
//
//  Created by Jorge Cadena on 22/08/25.
//

import SwiftUI

struct SearchWaves: View {
    var body: some View {
        ZStack {
            // Custom wave 1
            CustomWaveShape(phase: 4, strength: 70)
                .fill(
                    LinearGradient(
                        colors: [.wavesTop, .wavesBottom.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 500)
                .offset(y: 170)

            // Custom wave 2
            CustomWaveShape(phase: .pi / 5, strength: 70)
                .fill(
                    LinearGradient(
                        colors: [.wavesBottom, .wavesTop],
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
    SearchWaves()
}
