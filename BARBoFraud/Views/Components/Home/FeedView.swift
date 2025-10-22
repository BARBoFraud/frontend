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
                    Text("Aún No hay posts")
                    Spacer()
                }
            }else{
                ZStack{
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(vm.posts) { post in
                                PostView(post: post)
                            }
                        }
                        .padding()
                        .padding(.bottom, 50)
                    }
                    .refreshable {
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        do{
                            try await vm.fetch()
                        } catch { print(error)}
                    }   
                }
            }
            NewReportButton()
        }.task {
            do{
                try await vm.fetch()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    RootView()
}
