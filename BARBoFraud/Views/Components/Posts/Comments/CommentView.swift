//
//  CommentView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct CommentView: View {
    
    let comment : CommentResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(comment.username)
                .font(.subheadline)
                .bold()
            Text(comment.text)
                .font(.subheadline)
            Text("\(comment.date)")
                .font(.footnote)
            Divider()
        }
        .padding(4)
    }
}

#Preview {
    CommentView(comment: CommentResponse(id: 1, text: "Esto es un comentario", date: "\(Date.now)", username: "usuario"))
}
