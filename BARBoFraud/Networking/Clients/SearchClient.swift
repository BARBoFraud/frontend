//
//  SearchClient.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 12/10/25.
//

extension NetworkManager {
    func search(query: String) async throws -> [SearchResponse] {
        // Get JWT
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        return try await request("/reports/search/\(query)", token: token)
    }
    
    func fetchSearch(_ id: Int) async throws -> SearchPost {
        // Get JWT
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        let post: SearchPost = try await request("/reports/\(id)/search", token: token)
        
        return post
    }
}
