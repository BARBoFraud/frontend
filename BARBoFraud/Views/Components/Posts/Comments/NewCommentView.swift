//
//  NewComment.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct NewCommentView: View {
    let post: PostCommentView

        @State private var commentText = ""
        @FocusState private var isInputFocused: Bool

        var body: some View {
            VStack {
                HStack(spacing: 50){
                    NavigationButton(action: {print("Cancelar")}, text: "Cancelar", fgColor: .white, bgColor: Color("LandingBg1"))
                    Spacer()
                    NavigationButton(action: {print("Comentar")}, text: "Comentar", fgColor: .white, bgColor: Color("BlueAccent"))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                
                Divider()
                Spacer()
                
                post
                
                Spacer()
                Divider()
                
                TextField("Comentario nuevo...", text: $commentText)
                    .focused($isInputFocused)
                    .frame(maxHeight: 40)
                    .cornerRadius(10)
                    .keyboardType(.default)
                    .padding([.leading, .trailing])
            }
            .frame(maxHeight: .infinity)
            .background(Color("LandingBg2"))
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

#Preview {
    NewCommentView(post : PostCommentView())
}
