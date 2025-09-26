//
//  FeedView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct FeedView: View {
    // Mocked posts for now
    let posts: [Post] = [
        Post(
            id: 1,
            firstName: "Alice",
            lastName: "Smith",
            title: "scam-site.com",
            postText: "They tried to scam me with a fake invoice!",
            image: nil,
            date: Date(),
            likeCount: 4,
            commentCount: 0
        ),
        Post(
            id: 2,
            firstName: "Bob",
            lastName: "Johnson",
            title: "phishy-link.org",
            postText: "Received a phishing email from this address.",
            image: nil,
            date: Date(),
            likeCount: 12,
            commentCount: 1
        )
    ]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(posts) { post in
                    PostView(
                        username: "\(post.firstName) \(post.lastName)",
                        title: post.title,
                        postImage: Image("PostImage"),
                        postText: post.postText,
                        date: formatDate(post.date),
                        likeCount: post.likeCount,
                        commentCount: post.commentCount
                    )
                }
            }
            .padding()
        }
    }

    // Format Date -> String
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    FeedView()
}
