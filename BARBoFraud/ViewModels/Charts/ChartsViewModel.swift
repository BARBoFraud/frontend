//
//  ChartsViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/14.
//

import Foundation
import SwiftUICore

@MainActor
final class ChartsViewModel: ObservableObject {
    
    @Published var categoriesChart: PieChartData = []
    @Published var riskChart: PieChartData = []
    @Published var weeklyChart: BarChartData = []
    @Published var thisMonth : String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchCharts() async throws{
        isLoading = true
        do {
            categoriesChart = try await NetworkManager.shared.fetchCategoriesChart()
            riskChart = try await NetworkManager.shared.fetchRiskChart()
            let weeklyRawData = try await NetworkManager.shared.fetchWeeklyChart()
            thisMonth = DateUtils.getDateTitle(first: weeklyRawData.first!, last: weeklyRawData.last!)
            for item in weeklyRawData{
                weeklyChart.append(BarChartDataPoint(date: DateUtils.getFrom(date: item.date, .day), num: item.num))
            }
        } catch {
            errorMessage = "No se pudo obtener la información de las gráficas. \(error.localizedDescription)"
        }
        isLoading = false
    }
}
