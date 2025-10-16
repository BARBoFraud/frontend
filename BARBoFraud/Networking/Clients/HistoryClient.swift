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
}
