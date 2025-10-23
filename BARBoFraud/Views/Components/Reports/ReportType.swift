//
//  ReportType.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 21/09/25.
//

import SwiftUI

struct ReportType: View {
    @Binding var selectedCategoryID: Int
    @State private var isExpanded: Bool = true
    
    @StateObject private var vm = ReportsController()
    
    var body: some View {
        ZStack {
            VStack{
                Text("Tipo de fraude")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                
                if vm.isLoading {
                    VStack{
                        Spacer()
                        ProgressView("Cargando categorías...")
                            .frame(alignment: .center)
                            .padding()
                        Spacer()
                    }
                } else if let errorMessage = vm.errorMessage {
                    Text("Error: \(errorMessage)")
                        .frame(alignment: .center)
                        .foregroundColor(.warningRed)
                        .padding()
                } else {
                    ForEach(vm.categories, id: \.id){ category in
                        Button(action: {
                            selectedCategoryID = category.id
                            isExpanded = false
                        }) {
                            HStack() {
                                Image(systemName: selectedCategoryID == category.id ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedCategoryID == category.id ? .text : .gray)
                                    .font(.system(size: 20))
                                Text(category.name)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                        }.buttonStyle(.plain)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color.accentColor, lineWidth: 1)
                    .fill(.appBg)
            )
            .task {
                await vm.getCategories()
            }
        }
    }
}

#Preview {
    NewReport()
}
