//
//  HistoryViewModel.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 15/10/25.
//

import Foundation

@MainActor
final class HistoryViewModel : ObservableObject {
    @Published var results: [HistoryResponse] = []
    @Published var isLoading = false
    
    func fetchAll() async {
        isLoading = true
        
        do {
            let fetched = try await NetworkManager.shared.fetchAllHistory()
            await MainActor.run {
                self.results = fetched
            }
        } catch {
            print("Error al solicitar el historial: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
