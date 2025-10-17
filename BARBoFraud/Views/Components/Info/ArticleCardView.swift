//
//  ArticleCardView.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI

struct ArticleCardView: View {
    let article: ArticleDTO
    var action: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(article.title)
                .font(.headline)
                .foregroundColor(Color("Text"))
                .bold()
            
            Text(article.description)
                .font(.subheadline)
                .foregroundColor(Color("Text"))
            
            if let name = article.imageName {
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 140)
                    .clipped()
                    .cornerRadius(10)
            }
            
            HStack {
                Spacer()
                Button(action: action) {
                    Text("Consultar")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(.appBg)
                        .foregroundColor(Color("Text"))
                        .clipShape(Capsule())
                }
                .shadow(color: Color.black.opacity(0.35), radius: 1, x: 0, y: 4)
                Spacer()
            }
        }
        .padding()
        .frame(width: 300)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray, lineWidth: 1))
    }
}

#Preview {
    ArticleCardView(article: sampleArticles[0]) {}
}
