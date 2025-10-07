//
//  PostViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import Foundation

@MainActor
final class PostsViewModel: ObservableObject {
    @Published var posts: Feed = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let endpoint = URL(string: "http://localhost:3000/v1/reports/feed")!

    func fetch() async {
        isLoading = true
        errorMessage = nil
        do {
            let (data, response) = try await URLSession.shared.data(from: endpoint)
            guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
                throw URLError(.badServerResponse)
            }
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(Feed.self, from: data)
            posts = decoded
        } catch {
            errorMessage = "No se pudieron cargar las incidencias. \(error.localizedDescription)"
        }
        isLoading = false
    }
}
