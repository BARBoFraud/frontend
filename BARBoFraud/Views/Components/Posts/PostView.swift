//
//  Post.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = PostViewModel()
    
    @State private var actor: String = ""
    
    public var post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack{
                if (post.name != nil){
                    Text("\(post.name!) \(post.lastName!)")
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.leading, 10)
                }
                Spacer()
                if post.category == "Red social" || post.category == "Mensaje"{
                    Text(post.application!)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(PostUtils.getLabelBackgroundColor(for: post.application!))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }else{
                    Text("\(PostUtils.getCategoryLabel(from: post.category))")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(PostUtils.getLabelBackgroundColor(for: post.category))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Text(post.title)
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .center)
                      
            if post.username == "Instagram" || post.username == "Tik Tok"{
                Text("@\(actor)")
                    .font(.system(size: 18, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .center)
            }else{
                Text(actor)
                    .font(.system(size: 18, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if let loadedImage = vm.image {
                loadedImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 200)
                    .clipped()
                    .cornerRadius(10)
            } else if vm.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 200)
            }
            
            Text(post.description)
                .font(.system(size: 16, weight: .regular))
            Text(DateUtils.formatDate(from: post.date))
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.gray)
            
            HStack() {
                Spacer()
                CommentButton(initialCount: post.commentCount, id: post.id)
                Spacer()
                LikeButton(initialCount: post.likeCount, initiallyLiked: post.userLiked == 1, id: post.id)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.subheadline)
        }
        .padding()
        .background(.postBg)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            router.push(.postDetail(postId: post.id))
        }
        .task{
            if (post.image != nil) {
                await vm.loadImage(from: post.image!)
            }
            actor = PostUtils.getActor(from: post)
        }
    }
}

#Preview{
    RootView()
}
