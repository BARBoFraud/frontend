//
//  GraphsClient.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/14.
//

import Foundation

extension NetworkManager{
    
    func fetchCategoriesChart() async throws -> PieChartData{
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        let response: PieChartData = try await request("/categories/counts", token: token)
        print(" cat: \(response)")
        return try await request("/categories/counts", method: "GET", token: token)
    }
    
    func fetchRiskChart() async throws -> PieChartData{
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        let response: PieChartData = try await request("/risk/counts", token: token)
        print(" risk: \(response)")
        return try await request("/risk/counts", method: "GET", token: token)
    }
    
    func fetchSocialMediaChart() async throws -> BarChartData{
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
            throw NetworkError.noToken
        }
        return try await request("/socialMedia/counts", token: token)
    }
}
