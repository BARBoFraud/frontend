//
//  TopBar.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/06.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {

                Button(action: {
                    print("Menu tapped")
                }) {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("ofraud")
                    .font(.headline)
                    .foregroundStyle(.backArrow)
                    .bold()
                
                Spacer()
            
                Spacer()
                    .frame(width: 24)
            }
            .padding(.horizontal)
            .frame(height: 60)
            .background(.landingBg2)
        }
    }
}

#Preview {
    TopBar()
}
