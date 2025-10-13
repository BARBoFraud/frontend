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
                Text("teléfono")
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
    }
}

#Preview {
    PhonePostView(post: Post(name: "", lastName: "", id: 1,
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
