//
//  NewComment.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct NewCommentView: View {
    @StateObject private var vm = CommentsViewModel()
    @StateObject private var pvm = PostViewModel()

    let postId: Int
    
    @State private var title : String = ""
    @State private var actor : String = ""
    

    @State private var commentText = ""
    @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopViewNewComment(comment: comment)
            Group{
                if pvm.isLoading {
                    VStack{
                        Spacer()
                        ProgressView("Cargando Post")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                    }
                    
                }else if let error = pvm.errorMessage{
                    VStack{
                        Spacer()
                        Text(error).padding()
                        Spacer()
                    }
                }else{
                    ScrollView{
                        VStack{
                            Divider()
                            PostCommentView(postId: postId)
                            Divider()
                            TextField("Comentario nuevo...", text: $commentText)
                                .focused($isInputFocused)
                                .frame(maxHeight: 40)
                                .cornerRadius(10)
                                .keyboardType(.default)
                                .padding([.leading, .trailing])
                        }
                    }
                    
                }
            }
        }
        .background(.appBg)
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            isInputFocused = false
        }
        .onAppear {
            DispatchQueue.main.async {
                isInputFocused = true
            }
        }
    }
    
    func comment(){
        Task{
            let _ = await vm.comment(id: postId, text: commentText)
        }
    }
}

#Preview {
    NewCommentView(postId: 1)
}
