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

    @State private var actor: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ViewHeader(title: "Post")
            Group{
                if vm.isLoading {
                    VStack{
                        Spacer()
                        ProgressView("Cargando Post")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                    }
                    
                }else if let error = vm.errorMessage{
                    VStack{
                        Spacer()
                        Text(error)
                            .frame(alignment: .center)
                            .padding()
                        Spacer()
                    }
                }else{
                    ScrollView{
                        VStack(alignment: .leading, spacing: 20) {
                            HStack{
                                if (vm.post.name != nil){
                                    Text("\(vm.post.name!) \(vm.post.lastName!)")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                Spacer()
                                if vm.post.category == "Red social" || vm.post.category == "Mensaje"{
                                    Text(vm.post.application!)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(PostUtils.getLabelBackgroundColor(for: vm.post.application!))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }else{
                                    Text("\(PostUtils.getCategoryLabel(from: vm.post.category))")
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(PostUtils.getLabelBackgroundColor(for: vm.post.category))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            Text(vm.post.title)
                                .font(.system(size: 20, weight: .semibold))
                            Text(actor)
                                .font(.system(size: 18, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .center)
                            
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
                            
                            HStack(spacing: 100) {
                                CommentButton(initialCount: vm.post.commentCount, id: vm.post.id)
                                LikeButton(initialCount: vm.post.likeCount, initiallyLiked: vm.post.userLiked == 1, id: vm.post.id)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.subheadline)
                        }
                        .padding()
                        
                        Divider()
                        
                        CommentSection(id: postId)
                            .padding(.bottom, 20)
                    }
                }
            }.task {
                do{
                    try await vm.getPost(id: postId)
                    actor = PostUtils.getActor(from: vm.post)
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
    RootView()
}
