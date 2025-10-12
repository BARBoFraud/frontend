//
//  HTTPClientCategoryID.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 10/10/25.
//

import Foundation

struct HTTPClientCategoryID {
    func getCategoryID() async throws -> [IDCategoryRequest]{
        guard let url = URL(string: "http://localhost:4000/v1/categories/list") else {
            fatalError("Invalid URL" + "http://localhost:4000/v1/reports/create")
        }
        
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        httpRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data,response) = try await URLSession.shared.data(for: httpRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        let categories = try decoder.decode([IDCategoryRequest].self, from: data)
        return categories
    }
}
