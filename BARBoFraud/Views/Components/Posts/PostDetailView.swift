//
//  PostDetailView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import SwiftUI

struct PostDetailView: View {
    @StateObject var vm = PostViewModel()
    
    var postId: Int
    
    @State private var title : String = ""
    @State private var actor : String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PostHeader()
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
                    VStack(alignment: .leading, spacing: 20) {
                        Text(title)
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
                        Text(vm.post.date)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        // Buttons
                        HStack(spacing: 100) {
                            CommentButton(initialCount: vm.post.commentCount)
                            LikeButton(initialCount: vm.post.likeCount, initiallyLiked: vm.post.userLiked == 1, id: vm.post.id)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.subheadline)
                    }
                    .padding()
                    Divider()
                    CommentSection(id: vm.postID)
                }
            }.task {
                do{
                    try await vm.getPost(id: postId)
                    unwrapPost()
                    await vm.loadImage(from: vm.post.image)
                } catch {
                    print(error)
                }
            }
        }
        .background(.appBg)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    func unwrapPost(){
        switch vm.post.category{
        case "Página de internet":
            title = vm.post.url
        case "Red social":
            if vm.post.socialMedia == "Whatsapp"{ title = "\(vm.post.socialMedia) \(vm.post.phoneNumber)"}
            else if vm.post.socialMedia == "Facebook" {title = "\(vm.post.socialMedia) \(vm.post.username)"}
            else{ title = "\(vm.post.socialMedia) @\(vm.post.username)"}
                    
            
        case "Llamada":
            title = vm.post.phoneNumber
        case "Mensaje":
            title = vm.post.phoneNumber
        case "Correo electrónico":
            title = vm.post.email
        default:
            print("Invalid Category")
        }
    }
}

#Preview {
    RootView()
}
