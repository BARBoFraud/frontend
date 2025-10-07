//
//  TopBarView.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI

struct TopBarView: View {
    var title: String
    var onMenuTap: () -> Void = {}
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onMenuTap) {
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
                    .foregroundColor(Color("Text"))
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color("Text"))
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .foregroundColor(.white)
        .background(Color("TopBarBg"))
        .shadow(color: Color.black.opacity(0.35), radius: 6, x: 0, y: 4)
    }
}





#Preview {
    TopBarView(title: "oFraud")
}
