//
//  ChartsViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/14.
//

import Foundation

@MainActor
final class ChartsViewModel: ObservableObject {
    
    @Published var pieCharts: [PieChartData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchCharts() async throws{
        isLoading = true
        do {
            pieCharts.append(try await NetworkManager.shared.fetchCategoriesChart())
            pieCharts.append(try await NetworkManager.shared.fetchRiskChart())
            print(pieCharts)
        } catch {
            errorMessage = "No se pudo obtener la información de las gráficas. \(error.localizedDescription)"
        }
        isLoading = false
    }
}
