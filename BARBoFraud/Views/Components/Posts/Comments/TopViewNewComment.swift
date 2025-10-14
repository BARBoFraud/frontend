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
    
    var body: some View {
        ZStack(alignment: .top){
            Color(.appBg)
                .ignoresSafeArea(edges: .top)
                .shadow(color: Color.black.opacity(0.35), radius: 3, x: 0, y: 4)
            HStack(spacing: 50){
                NavigationButton(action: {router.pop()}, text: "Cancelar", fgColor: .white, bgColor: .landingBg1)
                Spacer()
                NavigationButton(action: {comment(); router.pop()}, text: "Comentar", fgColor: .white, bgColor: .blueAccent)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            .padding(.top, 30)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    TopViewNewComment(comment: {print("comentado papu")})
}
