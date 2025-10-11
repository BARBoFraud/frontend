//
//  Routes.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

enum Route : Hashable, Equatable {
    case landing
    case login
    case signup
    case info
    case home
    case search
    case emptyView
    case articleDetail(article: ArticleDTO)
    case postDetail(postId: Int)
    case newComment(post: Post)
}
