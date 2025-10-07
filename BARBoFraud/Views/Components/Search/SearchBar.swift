//
//  SearchBar.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 26/09/25.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchText = ""
    @State private var debounceTask: Task<Void, Never>?

    var body: some View {
        ZStack {
            // Background with rounded corners
           Rectangle()
               .fill(Color.searchBg)
               .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            // Custom search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search...", text: $searchText)
                    .foregroundColor(.black)
                
                // Show X mark when text is typed
                if (!searchText.isEmpty) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            searchText = ""
                        }
                }
            }
            .padding(8)
            .background(.searchBar)
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.top, 10)
        }
        .frame(height: 70)
        .onChange(of: searchText) {
            debounceTask?.cancel()
            
            debounceTask = Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                
                // Don't make API call if text is empty
                guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }
                
                do {
                    let results = try await NetworkManager.shared.search(query: searchText.trimmingCharacters(in: .whitespaces), token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsInR5cGUiOiJhY2Nlc3MiLCJhY3RvciI6InVzZXIiLCJpYXQiOjE3NTk4MDM0MDQsImV4cCI6MTc1OTgwNDMwNH0.CltYGlt1-ZM7Y56K7Ox-7F4MHpCyPPBnMDUuyI4e_-k")
                    await MainActor.run {
                        print("Results: \(results)")
                    }
                       
                } catch {
                    print("Search error: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    SearchBar()
}
