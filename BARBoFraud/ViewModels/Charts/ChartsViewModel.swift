//
//  ChartsViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/14.
//

import Foundation

@MainActor
final class ChartsViewModel: ObservableObject {
    
    @Published var categoriesChart: PieChartData = []
    @Published var riskChart: PieChartData = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchCharts() async throws{
        isLoading = true
        do {
            categoriesChart = try await NetworkManager.shared.fetchCategoriesChart()
            riskChart = try await NetworkManager.shared.fetchRiskChart()
        } catch {
            errorMessage = "No se pudo obtener la información de las gráficas. \(error.localizedDescription)"
        }
        isLoading = false
    }
}
