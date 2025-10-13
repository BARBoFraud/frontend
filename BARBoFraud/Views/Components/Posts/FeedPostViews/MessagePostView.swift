//
//  MessagePostView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/13.
//

import SwiftUI

struct MessagePostView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = PostViewModel()
    var post: Post
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MessagePostView(post: Post(name: "", lastName: "", id: 1,
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
