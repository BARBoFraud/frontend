//
//  HistoryViewModel.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 15/10/25.
//

import Foundation
import SwiftUI

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
    
    func getCategoryId(_ category: String) async -> Int {
        do {
            let fetched = try await NetworkManager.shared.getCategoryId(category)
            return fetched.id
        } catch {
            print("Error al solicitar el ID de la categoria '\(category)':\n\(error.localizedDescription)")
        }
        
        return 0
    }
    
    func updatePost(post: PostUpdate, id: Int) async {
        isLoading = true
        do {
            let _ = try await NetworkManager.shared.updatePost(post: post, id: id)
        } catch {
            print("Error al actualizar el reporte: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
