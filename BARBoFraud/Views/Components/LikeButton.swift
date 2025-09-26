//
//  LikeButton.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct LikeButton: View {
    @State private var isLiked : Bool = false
    @State private var likeCount : Int = 0
    
    init(initialCount: Int = 0, initiallyLiked: Bool = false) {
            _likeCount = State(initialValue: initialCount)
            _isLiked = State(initialValue: initiallyLiked)
    }
    
    func Like() -> Void {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
            isLiked = true
        }
        likeCount += 1
    }
    
    func Unlike() -> Void {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
            isLiked = false
        }
        likeCount -= 1
    }
        
    var body: some View {
        HStack {
            Text("\(likeCount)")
            
            Button(action: {
                if !isLiked{
                    Like()
                }else{
                    Unlike()
                }
                
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isLiked ? .red : .gray)
                    .scaleEffect(isLiked ? 1.2 : 1.0)
            }
        }.frame(width: 50, alignment: .leading)
    }
}

#Preview {
    LikeButton()
}
