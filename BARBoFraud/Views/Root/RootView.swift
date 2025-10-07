//
//  RootView.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 25/09/25.
//

import SwiftUI

struct RootView: View {
    // Create router for programmatic navigation
    @StateObject var router = Router()
    
    var body: some View {
        // Check router path to change screens
        NavigationStack(path: $router.path) {
            Landing()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .landing: Landing()
                    case .login: LogIn()
                    case .signup: SignUp()
                    case .info: Info()
                    case .home: Home()
                    case .search: Search()
                    case .emptyView: EmptyView()
                    case .articleDetail(let article): ArticleDetail(article: article)
                    case .postDetail : PostDetailView(post: Post(name: "", lastName: "", id: 0, category: "", date: "", description: "", image: "", url: "", website: "", socialMedia: "", username: "", email: "", phoneNumber: "", likeCount: 1, commentCount: 1, userLiked: 1))
                    }
                }
        }
        .environmentObject(router) // Make router an environment object
    }
}
