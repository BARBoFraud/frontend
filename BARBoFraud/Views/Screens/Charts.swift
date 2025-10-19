//
//  Charts.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/14.
//

import SwiftUI
import Charts

struct ChartsView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = ChartsViewModel()
    
    private var titulosGraficas = ["Número de reportes por categoría", "Reportes por riesgo"]
    private var colorMap: [String: Color]  = ["Correo electrónico": .blue, "Llamada": .cyan, "Mensaje": .black, "Página de internet": .green, "Red social": .brown]
    
    var body: some View {
        VStack(){
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
                    TabView {
                        VStack{
                            Text("Reportes por categoría")
                                .font(.title)
                                Chart(vm.categoriesChart) { item in
                                    SectorMark(
                                        angle: .value("Value", item.count),
                                        innerRadius: .ratio(0.0),
                                        angularInset: 0.1
                                    )
                                    .foregroundStyle(by: .value("Category", item.name))
                                    .annotation(position: .overlay) {
                                        if item.count != 0 {
                                            VStack {
                                                Text("\(item.name) \(item.count)")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                    }
                                }
                                .chartLegend(.hidden)
                                .frame(height: 500)
                                .padding()
                        }
                        
                        VStack{
                            Text("Reportes por riesgo")
                                .font(.title)
                            Chart(vm.riskChart) { item in
                                SectorMark(
                                    angle: .value("Value", item.count),
                                    innerRadius: .ratio(0),
                                    angularInset: 0.1
                                )
                                .foregroundStyle(by: .value("Category", item.name))
                                .annotation(position: .overlay) {
                                    if item.count != 0 {
                                        VStack {
                                            Text("\(item.name) \(item.count)")
                                                .font(.subheadline)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                }
                            }
                            .chartLegend(.hidden)
                            .frame(height: 500)
                            .padding()
                        }
                        
                        VStack{
                            Spacer()
                            Text("Reportes creados por día en la última semana")
                                .font(.title)
                            Spacer()
                            Text(vm.thisMonth)
                                .font(.title)
                            Chart(vm.weeklyChart) { item in
                                BarMark(
                                    x: .value("Date", item.date),
                                    y: .value("Reports", item.num)
                                )
                                .foregroundStyle(item.num > 0 ? .blue : .gray.opacity(0.3))
                            }
                            .chartYScale(domain: 0...Double(vm.weeklyChart.map { $0.num }.max() ?? 1))
                            .chartXAxis {
                                AxisMarks(values: vm.weeklyChart.map { $0.date }) { value in
                                    AxisGridLine()
                                    AxisTick()
                                    AxisValueLabel()
                                }
                            }
                            .frame(height: 400)
                            .padding()
                            Spacer()
                        }.padding()
                    }
                    .background(.appBg)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(maxHeight: .infinity)
                }
            }
        }
        .task {
            do{
                try await vm.fetchCharts()
            } catch {
                print(error)
            }
        }.navigationBarBackButtonHidden(true)
    }
}



#Preview {
    ChartsView()
}

/**
 Chart(data) { item in
     SectorMark(
         angle: .value("Value", item.count),
         innerRadius: .ratio(0),
         angularInset: 0
     )
     .foregroundStyle(by: .value("Category", item.name)
     .annotation(position: .overlay) {
         if(item.count != 0){
             VStack{
                 Text("\(item.count)")
                     .font(.subheadline)
                     .foregroundStyle(.white)
             }
         }
     }
 }
 .frame(height: 250)
 .padding()
 
 
 **/
