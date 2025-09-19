//
//  LikeButton.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct LikeButton: View {
    @State private var isLiked = false

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                isLiked.toggle()
            }
        }) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(isLiked ? .red : .gray)
                .scaleEffect(isLiked ? 1.2 : 1.0)
        }
    }
}

#Preview {
    LikeButton()
}
