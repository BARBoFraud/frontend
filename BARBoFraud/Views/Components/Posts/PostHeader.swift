//
//  PostHeader.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/11.
//

import SwiftUI

struct PostHeader: View {
    var body: some View {
        ZStack(alignment: .top){
            Color(.appBg)
                .ignoresSafeArea(edges: .top)
                .shadow(color: Color.black.opacity(0.35), radius: 3, x: 0, y: 4)
            HStack {
                BackArrowBtn()
                    .frame(width: 40, height: 40)
                
                Text("Post")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    PostHeader()
}
