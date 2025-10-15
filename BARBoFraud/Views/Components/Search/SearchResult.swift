//
//  SearchResult.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 12/10/25.
//

import SwiftUI

struct SearchResult: View {
    @ObservedObject var vm: SearchViewModel
    
    var body: some View {
        if vm.query.isEmpty {
            EmptyView()
        } else {
            if vm.isLoading {
                Spacer()
                ProgressView("Buscando")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                Spacer()
            } else if vm.results.isEmpty {
                Divider()
                ZStack {
                    Rectangle()
                        .fill(.appBg)
                        .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                    HStack {
                        Text("No se encontró ningún resultado")
                    }
                    .padding(.vertical, 10)
                }
                .fixedSize(horizontal: false, vertical: true)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.results) { result in
                            Divider()
                            ZStack {
                                Rectangle()
                                    .fill(.appBg)
                                    .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                                HStack {
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text(result.title)
                                            .font(.title2)
                                        Text(DateUtils.formatDate(from: result.createdAt))
                                            .font(.footnote)
                                            .foregroundStyle(.text.opacity(0.4))
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        let risk = result.riskLevel.lowercased()
                                        Text("Riesgo \(risk)")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(PostUtils.getRiskLabelBackgroundColor(for: result.riskLevel))
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                       
                                        Text("\(PostUtils.getCategoryLabel(from: result.category))")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(PostUtils.getLabelBackgroundColor(for: result.category))
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    Spacer()
                                }
                                .onTapGesture {
                                    Task {
                                        if let post = await vm.fetch(result.id) {
                                            print(post)
                                        } else {
                                            print("Error")
                                        }
                                    }
                                }
                                .padding(.vertical, 10)
                            } // ZStack
                            .fixedSize(horizontal: false, vertical: true)
                        } // ForEach
                    } // LazyVStack
                } // ScrollView
            } // else
        }
    }
}

#Preview {
    SearchResult(vm: SearchViewModel())
}
