//
//  FeedClient.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/09.
//

extension NetworkManager{
    func getFeed() async throws -> Feed {
        
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        
        return try await request("/reports/feed", token: token)
    }
    
    func like(postID : Int) async throws -> EmptyResponse {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        return try await request("/reports/like/\(postID)", method: "POST", token: token)
    }
    
    func unlike(postID : Int) async throws -> EmptyResponse {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        return try await request("/reports/unlike/\(postID)", method: "POST", token: token)
    }
    
    func comment(id reportID: Int, text: String) async throws -> EmptyResponse {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        let newComment = CommentRequest(text: text)
        return try await request("/reports/comment/\(reportID)", method: "POST", token: token, body: newComment)
    }
    
    func getComments(id reportID: Int) async throws -> Comments{
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        return try await request("/reports/comments/\(reportID)", token: token)
    }
    
    func getPost(id reportID: Int) async throws -> Post{
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        return try await request("/reports/\(reportID)/search", token: token)
    }
}
