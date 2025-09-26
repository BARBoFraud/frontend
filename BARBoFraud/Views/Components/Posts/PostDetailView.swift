//
//  PostDetailView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct PostDetailView: View {
    var username: String = "Diego Herrera"
    var title: String = "noesestafa.com"
    var postImage: Image? = Image("PostImage")
    var postText: String = "Este es el texto de una publicación larga con muchos detalles y más texto para probar el scroll."
    var date: String = "2025-09-12"
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Back Button
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    // Post content
                    Text(username)
                        .font(.system(size: 16, weight: .semibold))
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    if let postImage = postImage {
                        postImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .clipped()
                            .cornerRadius(10)
                    }
                    
                    Text(postText)
                        .font(.system(size: 16))
                    Text(date)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    // Buttons
                    HStack(spacing: 100) {
                        CommentButton()
                        LikeButton()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.subheadline)
                }
                .padding()
                
                VStack{
                    // Comments Section
                    ForEach(0..<10, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 4) {
                            CommentView(name : "\(index)", comment_text: "comentario", date: Date.now)
                            Divider()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    PostDetailView()
}
