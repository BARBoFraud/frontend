//
//  Charts.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/14.
//

import SwiftUI
import Charts

struct Charts: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = ChartsViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ViewHeader(title: "Charts")
            Group{
                if vm.isLoading {
                    VStack{
                        Spacer()
                        ProgressView("Cargando")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                    }
                }else if let error = vm.errorMessage{
                    VStack{
                        Spacer()
                        Text(error).padding()
                        Spacer()
                    }
                }else{
                    ScrollView{
                        VStack(spacing: 40) {
                            ForEach(vm.pieCharts.indices, id: \.self) { index in
                                let data: PieChartData = vm.pieCharts[index]
                                Text("Pie Chart")
                                    .font(.headline)
                                Chart(data) { (item: PieChartDataPoint) in
                                    SectorMark(
                                        angle: .value("Value", item.count),
                                        innerRadius: .ratio(0),
                                        angularInset: 20
                                    )
                                    .foregroundStyle(by: .value("Category", item.name))
                                    .annotation(position: .overlay) {
                                        Text(item.name)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                }
                                .frame(height: 250)
                                .padding()
                            }
                            }
                        }
                        .padding()
                    }
                }
            }
            .task {
                do{
                    try await vm.fetchCharts()
                    print("charts: \(vm.pieCharts)")
                } catch {
                    print(error)
            }
        }.navigationBarBackButtonHidden(true)
    }
}


#Preview {
    Charts()
}
