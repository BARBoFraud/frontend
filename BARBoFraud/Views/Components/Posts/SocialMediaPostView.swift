//
//  SocialMediaPostView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/09.
//

import SwiftUI

struct SocialMediaPostView: View {
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
                Text("\(post.socialMedia)")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(labelBackgroundColor(for: post.socialMedia))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text(post.username)
                .font(.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)

            if let url = URL(string: post.image){
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
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .contentShape(Rectangle()) // Makes entire card tappable
        .onTapGesture {
            router.push(.postDetail(post))
        }
    }
}

func labelBackgroundColor(for socialMedia: String) -> Color {
    switch socialMedia {
    case "Instagram":
        return Color(red: 225/255, green: 48/255, blue: 108/255)
    case "TikTok":
        return .black
    case "Twitter/X":
        return .black
    case "Whatsapp":
        return Color(red: 37/255, green: 211/255, blue: 102/255)
    case "Facebook":
        return Color(red: 24/255, green: 119/255, blue: 242/255)
    default:
        return .gray
    }
}


#Preview {
    RootView()
}
