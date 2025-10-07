//
//  CommentView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct CommentView: View {
    let name : String
    let comment_text : String
    let date : Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .font(.subheadline)
                .bold()
            Text(comment_text)
                .font(.subheadline)
            Text("\(date.formatted())")
                .font(.footnote)
            Divider()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CommentView(name : "Esteban", comment_text: "Esto es un comentario", date: Date.now)
}
