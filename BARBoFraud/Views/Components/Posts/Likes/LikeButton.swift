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
    var postID : Int
    
    init(initialCount: Int = 0, initiallyLiked: Bool = false, id: Int) {
            _likeCount = State(initialValue: initialCount)
            _isLiked = State(initialValue: initiallyLiked)
            postID = id
    }
    
    func Like() -> Void {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
            isLiked = true
            Task{
                do{
                    let _ = try await NetworkManager.shared.like(postID: postID)
                }catch{
                    print("error \(error)")
                }
            }
        }
        likeCount += 1
    }
    
    func Unlike() -> Void {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
            isLiked = false
            Task{
                do{
                    let _ = try await NetworkManager.shared.unlike(postID: postID)
                }catch{
                    print("error \(error)")
                }
            }
        }
        likeCount -= 1
    }
        
    var body: some View {
        HStack {
            Text("\(likeCount)")
            
            Button(action: {
                if !isLiked{ Like() }
                else{ Unlike() }
            }){
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isLiked ? .red : .gray)
                    .scaleEffect(isLiked ? 1.2 : 1.0)
            }
        }.frame(width: 70, alignment: .leading)
    }
}

#Preview {
    LikeButton(id: 1)
}
