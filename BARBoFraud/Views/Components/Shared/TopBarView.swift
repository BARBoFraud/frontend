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
        ZStack(alignment: .top){
            Color(Color(.topBarBg))
                .ignoresSafeArea(edges: .top)
                .shadow(color: Color.black.opacity(0.35), radius: 3, x: 0, y: 4)
            HStack(spacing: 16) {
                Button(action: onMenuTap) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.text)
                }
                .buttonStyle(PlainButtonStyle())
                
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.text)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}





#Preview {
    TopBarView(title: "oFraud")
}
