//
//  PostCommentView.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/25.
//

import SwiftUI

struct PostCommentView: View {
    @StateObject var vm = PostViewModel()
    
    var postId: Int
    
    @State private var title : String = ""
    @State private var actor : String = ""
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                //Text("\(vm.post.name) \(vm.post.lastName)")
                    //.font(.system(size: 16, weight: .semibold))
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                //Imagen
                
                Text(vm.post.description)
                    .font(.system(size: 16))
                Text(DateUtils.formatDate(from: vm.post.date)) 
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .task {
            do{
                try await vm.getPost(id: postId)
                (title, actor) = PostUtils.unwrapPost(from: vm.post)
                await vm.loadImage(from: vm.post.image)
            } catch {
                print(error)
            }
        }
        .background(.appBg)
    }
}

#Preview {
    PostCommentView(postId: 1)
}
