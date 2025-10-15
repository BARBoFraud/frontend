//
//  CommentButton.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct CommentButton: View {
    @EnvironmentObject var router: Router
    @State private var commentCount : Int = 0
    var postId : Int
    
    init(initialCount: Int, id: Int) {
            _commentCount = State(initialValue: initialCount)
            postId = id
    }
        
    var body: some View {
        HStack {
            Text("\(commentCount)")
            
            Button(action: {
                router.push(.newComment(postId: postId))
            }) {
                Image(systemName: "bubble")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
        }.frame(width: 70, alignment: .leading)
    }
}

#Preview {
    CommentButton(initialCount: 0, id: 1)
}
