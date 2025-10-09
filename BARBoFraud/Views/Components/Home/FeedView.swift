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
                .refreshable {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    await vm.fetch()
                }
            }
        }.task {
            await vm.fetch()
        }
    }
}

#Preview {
    FeedView()
}
