//
//  PhonePostView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/09.
//

import SwiftUI

struct PhonePostView: View {
    @EnvironmentObject var router: Router
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack{
                if let name = post.name{
                    Text("\(name) \(post.lastName!)")
                        .font(.system(size: 16, weight: .semibold))
                }
                Spacer()
                Text("phone")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text(post.phoneNumber)
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(post.description)
                .font(.system(size: 16, weight: .regular))
            Text(post.date)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.gray)
            
            //Comentarios y likes
            HStack(spacing: 100) {
                CommentButton(initialCount: post.commentCount)
                LikeButton(initialCount: post.likeCount, initiallyLiked: post.userLiked == 1)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.subheadline)
        }
        .padding()
        .background(.appBg)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .contentShape(Rectangle()) // Makes entire card tappable
        .onTapGesture {
            router.push(.postDetail(post))
        }
    }
}

#Preview {
    RootView()
}
