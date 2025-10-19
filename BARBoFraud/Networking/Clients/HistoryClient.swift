//
//  HistoryClient.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 15/10/25.
//

extension NetworkManager {
    func fetchAllHistory() async throws -> [HistoryResponse] {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        
        return try await request("/reports/history", token: token)
    }
    
    func getCategoryId(_ category: String) async throws -> CategoryIdResponse {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }

        return try await request("/categories/\(category)", token: token)
    }
    
    func updatePost(post: PostUpdate, id: Int) async throws {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }

        try await request(
            "/reports/update/\(id)",
            method: "PUT",
            token: token,
            body: post
        )
    }
}
