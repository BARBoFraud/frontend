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
                // Post preview at top
                VStack(alignment: .leading, spacing: 8) {
                    Text(post.username)
                        .font(.subheadline)
                    Text(post.title)
                        .font(.headline)
                    Text(post.postText)
                        .font(.body)
                }
                .padding()

                Spacer()

                //Nuevo comentario
                VStack(spacing: 0) {
                    Divider()
                    TextEditor(text: $commentText)
                        .focused($isInputFocused)
                        .frame(minHeight: 80)
                        .padding(8)
                }
                .background(Color("LandingBg1"))
            }
            .navigationTitle("Comment")
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
