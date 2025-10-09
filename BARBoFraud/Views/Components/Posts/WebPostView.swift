//
//  WebPostView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/09.
//

import SwiftUI

struct WebPostView: View {
    @EnvironmentObject var router: Router
    let imageLocation = AppConfig.imageStorageUrl
    
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack{
                if let name = post.name{
                    Text("\(name) \(post.lastName!)")
                        .font(.system(size: 16, weight: .semibold))
                }
                Spacer()
                Text("web")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text(post.website)
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
            Text(post.url)
                .font(.system(size: 20, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .center)

            if let url = URL(string: imageLocation + post.image){
                AsyncImage(url: url){ image in
                    image
                        .image?.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 200)
                        .clipped()
                        .cornerRadius(10)
                }
            }
            
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
