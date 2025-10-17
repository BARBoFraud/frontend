//
//  TopViewNewComment.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/12.
//

import SwiftUI

struct TopViewNewComment: View {
    @EnvironmentObject var router: Router
    
    var comment : () -> Void
    var isFieldEmpty: Bool
    
    var body: some View {
        ZStack(alignment: .top){
            Color(.appBg)
                .ignoresSafeArea(edges: .top)
                .shadow(color: Color.black.opacity(0.35), radius: 3, x: 0, y: 4)
            HStack(spacing: 50){
                NavigationButton(action: {router.pop()}, text: "Cancelar", fgColor: .black, bgColor: .postBg).shadow(radius: 1)
                Spacer()
                NavigationButton(
                    action: {
                        comment()
                        router.pop()
                    },
                    text: "Comentar",
                    fgColor: .white,
                    bgColor: .blueAccent
                )
                .disabled(!isFieldEmpty)
                .opacity(isFieldEmpty ? 1.0 : 0.5)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .padding(.top, 30)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    TopViewNewComment(comment: {print("comentado papu")}, isFieldEmpty: true)
}
