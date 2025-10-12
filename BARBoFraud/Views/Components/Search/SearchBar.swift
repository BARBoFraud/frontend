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
                .fill(.appBg).ignoresSafeArea()
            // Custom search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading)
                TextField("Search...", text: $searchText)
                    .foregroundColor(.black)
                    .padding(.vertical, 9.5)
                
                // Show X mark when text is typed
                if (!searchText.isEmpty) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                        .onTapGesture {
                            searchText = ""
                        }
                }
            }
            .background(.searchBar)
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .fixedSize(horizontal: false, vertical: true)
        .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 4)
        .onChange(of: searchText) {
            debounceTask?.cancel()
            
            debounceTask = Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                
                // Don't make API call if text is empty
                guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }
                
                do {
                    let results = try await NetworkManager.shared.search(query: searchText.trimmingCharacters(in: .whitespaces))
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
