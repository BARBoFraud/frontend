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
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopViewNewComment(
                comment: comment,
                isFieldEmpty: !commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            )
            Group{
                if pvm.isLoading {
                    VStack{
                        Spacer()
                        ProgressView("Cargando Post")
                            .frame(alignment: .center)
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                        Spacer()
                    }
                    
                }else if let error = pvm.errorMessage{
                    VStack{
                        Spacer()
                        Text(error)
                            .padding()
                            .frame(alignment: .center)
                        Spacer()
                    }
                }else{
                    ScrollView{
                        VStack{
                            Divider()
                            PostCommentView(postId: postId)
                            Divider()
                            TextField("Comentario nuevo...", text: $commentText)
                                .focused($isFocused)
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
            isFocused = false
        }
        .onAppear {
            DispatchQueue.main.async {
                isFocused = true
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
