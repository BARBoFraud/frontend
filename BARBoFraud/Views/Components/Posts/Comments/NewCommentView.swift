//
//  NewComment.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct NewCommentView: View {
    @StateObject private var vm = CommentsViewModel()
    
    let post: Post

        @State private var commentText = ""
        @FocusState private var isInputFocused: Bool

    var body: some View {
        VStack {
            ZStack(alignment: .top){
                Color(.appBg)
                    .ignoresSafeArea(edges: .top)
                    .shadow(color: Color.black.opacity(0.35), radius: 3, x: 0, y: 4)
                HStack(spacing: 50){
                    NavigationButton(action: {print("Cancelar")}, text: "Cancelar", fgColor: .white, bgColor: .landingBg1)
                    Spacer()
                    NavigationButton(action: {comment()}, text: "Comentar", fgColor: .white, bgColor: .blueAccent)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                .padding(.top, 30)
            }
            .fixedSize(horizontal: false, vertical: true)
            
           ScrollView{
               VStack{
                   
                   Divider()
                   
                   PostCommentView()
                   
                   Divider()
                   
                   //Text(get.usuario)

                   TextField("Comentario nuevo...", text: $commentText)
                       .focused($isInputFocused)
                       .frame(maxHeight: 40)
                       .cornerRadius(10)
                       .keyboardType(.default)
                       .padding([.leading, .trailing])
               }
            }
            .background(.appBg)
            .onTapGesture {
                isInputFocused = false
            }
            .onAppear {
                DispatchQueue.main.async {
                    isInputFocused = true
                }
            }
        }
    }
    func comment(){
        Task{
            do{
                let _ = try await vm.comment(id: post.id, text: commentText)
            }catch{
                print("No se pudo publicar el comentario: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    NewCommentView(post: Post(name: "", lastName: "", id: 1, category: "", date: "", description: "", image: "", url: "", website: "", socialMedia: "", username: "", email: "", phoneNumber: "", likeCount: 1, commentCount: 1, userLiked: 1))
}
