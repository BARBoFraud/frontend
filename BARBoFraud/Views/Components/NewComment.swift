//
//  NewComment.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct NewComment: View {
    let post: PostView

        @State private var commentText = ""
        @FocusState private var isInputFocused: Bool

        var body: some View {
            VStack {
                
                HStack(){
                    Button("Cancelar"){
                        print("Comentario cancelado")
                    }
                    Spacer()
                    
                    Button("Comentar"){
                        print("Postear comentario")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading, spacing: 8) {
                    PostCommentView()
                }
                .padding()

                Spacer()
                Divider()
                
                
                VStack(spacing: 0) {
                    Divider()
                    TextEditor(text: $commentText)
                        .focused($isInputFocused)
                        .frame(maxHeight: 40)
                        .cornerRadius(10)
                        .padding(10)
                }
                .background(Color("LandingBg1"))

                
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isInputFocused = true
                }
            }
        }
}

#Preview {
    NewComment(post : PostView())
}
