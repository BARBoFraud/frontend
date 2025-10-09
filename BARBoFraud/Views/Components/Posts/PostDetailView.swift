//
//  PostDetailView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct PostDetailView: View {
    var post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                BackArrowBtn()
                    .frame(width: 40, height: 40)
                
                Text("Post")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
            .background(Color("AppBg").ignoresSafeArea(edges: .top))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text(post.username)
                        .font(.system(size: 16, weight: .semibold))
                    Text(post.website)
                        .font(.system(size: 22, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Image(post.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .clipped()
                            .cornerRadius(10)
                    
                    Text(post.description)
                        .font(.system(size: 16))
                    Text(post.date)
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
        .background(Color("LandingBg1"))
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    RootView()
}
