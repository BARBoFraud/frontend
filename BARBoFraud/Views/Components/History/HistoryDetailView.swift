//
//  HistoryDetailView.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 15/10/25.
//

import SwiftUI

struct HistoryDetailView: View {
    @StateObject var vm = PostViewModel()
    
    var postId: Int

    @State private var actor: String = ""
    @State private var commentCount: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ViewHeader(title: "Post")
            Group{
                if vm.isLoading {
                    VStack{
                        Spacer()
                        ProgressView("Cargando Post")
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
                }else{
                    ScrollView{
                        VStack(alignment: .leading, spacing: 20) {
                            Text(vm.post.title)
                                .font(.system(size: 20, weight: .semibold))
                            if actor != "" {
                                Text(actor)
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            
                            if let loadedImage = vm.image {
                                loadedImage
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(10)
                            } else if vm.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                            }
                            
                            Text(vm.post.description)
                                .font(.system(size: 16))
                            Text(DateUtils.formatDate(from: vm.post.date))
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        
                        Divider()
                    }
                }
            }.task {
                do{
                    try await vm.getPost(id: postId)
                    actor = PostUtils.getActor(from: vm.post)
                    print(vm.post.commentCount)
                    if (vm.post.image != nil){
                        await vm.loadImage(from: vm.post.image!)
                    }
                } catch {
                    print(error)
                }
            }
        }
        .background(.appBg)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .bottom)
    }

}

#Preview {
    HistoryDetailView(postId: 1)
}
