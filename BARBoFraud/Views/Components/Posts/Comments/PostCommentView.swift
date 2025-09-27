//
//  PostCommentView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/25.
//

import SwiftUI

struct PostCommentView: View {
    var username: String = "Diego Herrera"
    var title: String = "noesestafa.com"
    var postImage: Image? = Image("PostImage")
    var postText: String = "Este es el texto de una publicación larga con muchos detalles y más texto para probar el scroll."
    var date: String = "2025-09-12"
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text(username)
                    .font(.system(size: 16, weight: .semibold))
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if let postImage = postImage {
                    postImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Text(postText)
                    .font(.system(size: 16))
                Text(date)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .background(Color("LandingBg2"))
    }
}

#Preview {
    PostCommentView()
}
