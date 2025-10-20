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
    
    let categoryColors: [String: Color] = [
        "Red social": .red,
        "Correo electrónico": .orange,
        "Llamada": .pink,
        "Mensaje": .green,
        "Página de internet": .blue
    ]
    
    let categoryName: [String: String] = [
        "Red social": "Red social",
        "Correo electrónico": "Email",
        "Llamada": "Llamada",
        "Mensaje": "Mensaje",
        "Página de internet": "Web"
    ]
    
    let riskColors: [String: Color] = [
        "Alto": .warningRed,
        "Medio": Color(red: 255/255, green: 87/255, blue: 34/255),
        "Bajo": Color(red: 255/255, green: 193/255, blue: 7/255)
    ]
    
    var body: some View {
        VStack(){
            ViewHeader(title: "Estadísticas")
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
                                        innerRadius: .ratio(0.2),
                                        angularInset: 0
                                    )
                                    .foregroundStyle(categoryColors[item.name, default: .gray])
                                    .annotation(position: .overlay) {
                                        if item.count != 0 {
                                            VStack {
                                                Text("\(categoryName[item.name, default: "Other"]): \(item.count)")
                                                    .foregroundStyle(.white)
                                                    .font(.subheadline)
                                                    .fontWeight(.bold)
                                                    .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
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
                                    innerRadius: .ratio(0.3),
                                    angularInset: 0
                                )
                                .foregroundStyle(riskColors[item.name, default: .gray])
                                .annotation(position: .overlay) {
                                    if item.count != 0 {
                                        VStack {
                                            Text("\(item.name): \(item.count)")
                                                .foregroundStyle(.white)
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
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
                                .foregroundStyle(item.num > 0 ? .blueAccent : .gray.opacity(0.3))
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
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .overlay(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 10)
                            .fill(.blueAccent.opacity(0.4))
                                    .frame(width: 60, height: 20)
                                    .padding(.bottom, 15)
                            }
                    .frame(maxHeight: .infinity)
                }
            }
            .task {
                do{
                    try await vm.fetchCharts()
                } catch {
                    print(error)
                }
            }
        }
        .background(.appBg)
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    ChartsView()
}
