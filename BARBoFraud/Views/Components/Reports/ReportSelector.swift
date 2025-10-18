//
//  ReportSelector.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 21/09/25.
//

import SwiftUI

struct ReportSelector: View {
    @Binding var selectedType: String
    @Binding var selectedCategoryID: Int?
    @State private var isExpanded: Bool = true
    
    @StateObject private var vm = ReportsController()
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Tipo de fraude")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                if vm.isLoading {
                    Spacer()
                    ProgressView("Cargando categorías...").padding()
                    Spacer()
                } else if let errorMessage = vm.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.warningRed)
                        .padding()
                } else {
                    ForEach(vm.categories, id: \.id){ category in
                        Button(action: {
                            selectedType = category.name
                            selectedCategoryID = category.id
                            isExpanded = false
                        }) {
                            HStack() {
                                Image(systemName: selectedType == category.name ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedType == category.name ? .black : .gray)
                                    .font(.system(size: 20))
                                Text(category.name)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color.accentColor, lineWidth: 1)
                    .frame(width: 300)
            )
            .frame(width: 300)
            .task {
                await vm.getCategories()
            }
        }
    }
}

#Preview {
    struct prev: View {
        @State var selectedType: String = ""
        @State var selectedCategoryID: Int? = nil
        
        var body: some View {
            ReportSelector(selectedType: $selectedType, selectedCategoryID: $selectedCategoryID)
        }
    }
    return prev()
}
