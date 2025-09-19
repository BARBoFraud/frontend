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
           /* HStack(spacing: 100) {
                NavigationLink {
                    NewComment() }
                label: {
                    Label("Comment", systemImage: "bubble.right")
                }
                
                Button(action: {}) {
                    Label("12", systemImage: "heart")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(Color("BlueAccent"))
            .font(.subheadline)*/
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

#Preview{
    PostView()
}
