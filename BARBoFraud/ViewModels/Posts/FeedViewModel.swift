//
//  FeedViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import Foundation

@MainActor
final class FeedViewModel: ObservableObject {
    
    private let baseUrl = AppConfig.apiBaseUrl
    
    @Published var posts: Feed = []
    @Published var isLoading = true
    @Published var errorMessage: String?

    private lazy var endpoint = URL(string: "\(baseUrl)/reports/feed")!
    //private let endpoint = URL(string: "http://192.168.1.79:4000/v1/reports/feed")! //iphone
    func fetch() async {
        isLoading = true
        errorMessage = nil
        do {
            guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
                throw NetworkError.noToken
            }
            
            var httpRequest = URLRequest(url: endpoint)
            httpRequest.httpMethod = "GET"
            httpRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: httpRequest)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                throw URLError(.badServerResponse)
            }
            let decoded = try JSONDecoder().decode(Feed.self, from: data)
            posts = decoded
        } catch {
            errorMessage = "No se pudieron cargar las incidencias. \(error.localizedDescription)"
        }
        //isLoading = false
    }
}
