//
//  Post.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct PostView: View {
    var username: String = "Diego Herrera"
    var title: String = "noesestafa.com"
    var postImage: Image? = Image("PostImage")
    var postText : String = "Este es el texto de una publicación"
    var date: String = "2025-09-12"
    var likeCount : Int = 0
    var commentCount : Int = 0
    
    @State private var showingDetail = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(username)
                .font(.system(size: 16, weight: .semibold))
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)

            if let postImage = postImage {
                postImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .clipped()
                    .cornerRadius(10)
            }
            
            Text(postText)
                .font(.system(size: 16, weight: .regular))
            Text(date)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.gray)
            
            //Comentarios y likes
            HStack(spacing: 100) {
                CommentButton(initialCount: 0)
                LikeButton(initialCount: 15, initiallyLiked: true)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.subheadline)
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .contentShape(Rectangle()) // makes entire card tappable
        .onTapGesture {
            showingDetail = true
        }
        .sheet(isPresented: $showingDetail) {
            PostDetailView(
                username: username,
                title: title,
                postImage: postImage,
                postText: postText,
                date: date
            )
        }
    }
}

#Preview{
    PostView()
}
