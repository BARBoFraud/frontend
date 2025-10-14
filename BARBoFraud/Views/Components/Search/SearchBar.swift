//
//  SearchBar.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 26/09/25.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var vm: SearchViewModel
    @State private var searchText = ""
    @State private var debounceTask: Task<Void, Never>?
    @FocusState var isFocused: Bool

    var body: some View {
        ZStack {
            // Background with rounded corners
           Rectangle()
                .fill(.appBg).ignoresSafeArea()
                .shadow(color: .black.opacity(0.35), radius: 3, x: 0, y: 4)
            // Custom search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading)
                TextField("Search...", text: $searchText)
                    .focused($isFocused)
                    .foregroundColor(.black)
                    .padding(.vertical, 9.5)
                
                // Show X mark when text is typed
                if (!searchText.isEmpty) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                        .onTapGesture {
                            searchText = ""
                            vm.query = ""
                            vm.results = []
                        }
                }
            }
            .background(.searchBar)
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .fixedSize(horizontal: false, vertical: true)
        .onChange(of: searchText) {
            debounceTask?.cancel()
            
            debounceTask = Task {
                try? await Task.sleep(nanoseconds: 500_000_000)
                
                let trimmed = searchText.trimmingCharacters(in: .whitespaces)
                await vm.search(query: trimmed)
//                await MainActor.run {
//                    print("Results: \(vm.results)")
//                }
            }
        }
    }
}

#Preview {
    SearchBar(vm: SearchViewModel())
}
