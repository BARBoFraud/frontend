//
//  SocialMediaPostView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/09.
//

import SwiftUI

struct SocialMediaPostView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = PostViewModel()
    
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
            
            if post.username != "" {
                Text(post.username)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
            }else if post.phoneNumber != "" {
                Text(post.phoneNumber)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if let loadedImage = vm.image {
                loadedImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 200)
                    .clipped()
                    .cornerRadius(10)
            } else if vm.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 200)
            }
            
            Text(post.description)
                .font(.system(size: 16, weight: .regular))
            Text(DateUtils.formatDate(from: post.date))
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.gray)
            
            HStack() {
                Spacer()
                CommentButton(initialCount: post.commentCount, id: post.id)
                Spacer()
                LikeButton(initialCount: post.likeCount, initiallyLiked: post.userLiked == 1, id: post.id)
                Spacer()
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
            router.push(.postDetail(postId: post.id))
        }
        .task{
            await vm.loadImage(from: post.image)
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
    SocialMediaPostView(post: Post(name: "", lastName: "", id: 1,
                                   category: "Phishing",
                                   date: "2025-10-09T18:01:21.000Z",
                                   description: "Received a fake email claiming to be from my bank asking for login credentials. The email looked official but had a suspicious URL.",
                                   image: "https://example.com/images/phishing-email.png",
                                   url: "http://fakebanklogin.com",
                                   website: "examplebank.com",
                                   socialMedia: "Twitter",
                                   username: "@john_doe123",
                                   email: "scammer@phishingsite.com",
                                   phoneNumber: "555-123-4567",
                                   likeCount: 2,
                                   commentCount: 8,
                                   userLiked: 0))
}
