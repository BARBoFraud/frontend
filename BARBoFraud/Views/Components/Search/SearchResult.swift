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
                                    if let website = result.website {
                                        Text(website)
                                    }
                                    if let email = result.email {
                                        Text(email)
                                    }
                                    if let phone = result.phoneNumber {
                                        Text(phone)
                                    }
                                    if let social = result.socialMedia {
                                        Text(social)
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
