//
//  SearchViewModel.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 12/10/25.
//

import Foundation

@MainActor
final class SearchViewModel : ObservableObject {
    @Published var query: String = ""
    @Published var results: [SearchResponse] = []
    @Published var isLoading = false
    
    func search(query: String) async {
        isLoading = true
        
        await MainActor.run { self.query = query }
        
        // Don't make API call if text is empty
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            await MainActor.run { self.results = [] }
            return
        }
        
        await MainActor.run { self.isLoading = true }
        defer { Task { @MainActor in self.isLoading = false } }
        
        do {
            let fetched = try await NetworkManager.shared.search(query: query)
            await MainActor.run {
                self.results = fetched
            }
        } catch {
            print("Error al hacer el request al servidor: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func fetch(_ id: Int) async -> Post? {
        do {
            return try await NetworkManager.shared.fetchSearch(id)
        } catch {
            print("Error al solicitar el reporte con ID: \(id).\n\(error.localizedDescription)")
            return nil
        }
    }
}
