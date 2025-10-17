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
                            Text("Número de reportes creados en la última semana")
                                .font(.title)
                        }
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
