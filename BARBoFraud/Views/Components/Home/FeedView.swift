//
//  FeedView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var vm = FeedViewModel()
    

    var body: some View {
        Group{
            if vm.isLoading {
                VStack{
                    Spacer()
                    Text("Cargando").padding()
                    Spacer()
                }
                
            }else if let error = vm.errorMessage{
                VStack{
                    Spacer()
                    Text(error).padding()
                    Spacer()
                }
            }else if vm.posts.isEmpty{
                VStack{
                    Spacer()
                    Text("No hay posts")
                    Spacer()
                }
            }else{
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(vm.posts) { post in
                            PostView(post: post)
                        }
                    }
                    .padding()
                }
            }
        }.task {
            await vm.fetch()
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    FeedView()
}
