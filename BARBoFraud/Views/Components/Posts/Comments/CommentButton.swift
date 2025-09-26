//
//  CommentButton.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct CommentButton: View {
    @State private var commentCount : Int = 0
    
    init(initialCount: Int = 0) {
            _commentCount = State(initialValue: initialCount)
    }
    
    
    func Comment() -> Void {
        print("User comment")
    }
    
        
    var body: some View {
        HStack {
            Text("\(commentCount)")
            
            Button(action: {
                Comment()
            }) {
                Image(systemName: "bubble")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
            }
        }.frame(width: 50, alignment: .leading)
    }
}

#Preview {
    CommentButton()
}
