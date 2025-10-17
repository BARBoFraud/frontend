//
//  ChartsDTO.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/14.
//

import Foundation

typealias BarChartData = [BarChartDataPoint]
typealias PieChartData = [PieChartDataPoint]
typealias HistogramData = [HistogramDataPoint]

struct BarChartDataPoint: Decodable, Identifiable{
    var id = UUID()
    let label: String
    let value: Double
}

struct PieChartDataPoint: Decodable, Identifiable{
    let id = UUID()
    let name: String
    let count: Int
}

struct HistogramDataPoint: Decodable, Identifiable{
    var id = UUID()
    let score: Double
}

enum CodingKeys: String, CodingKey{
    case label, value, name, count, score
}
