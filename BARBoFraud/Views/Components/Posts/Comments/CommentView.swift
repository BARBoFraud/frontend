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
            Text("\(comment.name) \(comment.lastName)")
                .font(.subheadline)
                .bold()
            Text(comment.text)
                .font(.subheadline)
            Text(DateUtils.formatDate(from: comment.date, includeTime: true))
                .font(.footnote)
            Divider()
        }
        .padding(4)
    }
}

#Preview {
    CommentView(comment: CommentResponse(id: 1, text: "Esto es un comentario", name: "Balatro", lastName: "Balatrez", date: "2025-10-12T20:04:37.000Z"))
}
