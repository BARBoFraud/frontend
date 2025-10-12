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
    @Binding var nextStep: Bool
    @State private var expanded: Bool = true
    @State private var isLoading = true
    @State private var errorMessage: String? = nil
    
    @StateObject private var vm = ReportsController()
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Button(action: {
                        withAnimation{
                            expanded.toggle()
                        }
                    }) {
                        Image(systemName: expanded ? "chevron.right" : "chevron.down")
                            .font(.title2)
                    }
                    .foregroundColor(.text)
                    Spacer()
                    Text("Tipo de fraude")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                if expanded {
                    if isLoading {
                        ProgressView("Cargando categorías...")
                            .padding()
                    } else if let errorMessage = errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ForEach(vm.categories, id: \.id){ category in
                            Button(action: {
                                selectedType = category.name
                                selectedCategoryID = category.id
                                withAnimation {
                                    expanded = false
                                    nextStep = true
                                }
                            }) {
                                HStack() {
                                    // Radio button simple
                                    Image(systemName: selectedType == category.name ? "largecircle.fill.circle" : "circle")
                                        .foregroundColor(selectedType == category.name ? .blue : .gray)
                                        .font(.system(size: 20))
                                    
                                    Text(category.name)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 25)
                            }
                        }
                    }
                }
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color.blue, lineWidth: 3)
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
        @State var nextStep: Bool = false
        @State var selectedType: String = ""
        @State var selectedCategoryID: Int? = nil
        
        var body: some View {
            ReportSelector(selectedType: $selectedType, selectedCategoryID: $selectedCategoryID, nextStep: $nextStep)
        }
    }
    return prev()
}
