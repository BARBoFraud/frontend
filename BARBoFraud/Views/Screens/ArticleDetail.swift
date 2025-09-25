//
//  ArticleDetailView.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI

struct ArticleDetail: View {
    let article: ArticleDTO
    
    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                if let name = article.imageName {
                    ZStack(alignment: .bottom) {
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 210)
                            .frame(maxWidth: .infinity)
                            .clipped()
                        
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.6)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(height: 120)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(article.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.6), radius: 6, x: 0, y: 2)
                        }
                        .padding([.leading, .bottom], 16)
                    }
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 6)
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        Text("Por \(article.author)")
                            .font(.caption)
                            .foregroundColor(Color("Text").opacity(0.8))
                        
                        Text("•")
                            .font(.caption)
                            .foregroundColor(Color("Text").opacity(0.6))
                        
                        Text(article.date)
                            .font(.caption)
                            .foregroundColor(Color("Text").opacity(0.6))
                        
                        Spacer()
                    }
                    
                    Divider().background(Color("Text").opacity(0.06))
                    
                    Text(article.description)
                        .font(.body)
                        .foregroundColor(Color("Text"))
                        .multilineTextAlignment(.leading)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: 330)
                .padding()
                
                Spacer(minLength: 24)
            }
            .padding(.top, 12)
        }
        .background(Color("AppBg").ignoresSafeArea())
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}





#Preview {
    ArticleDetail(article: sampleArticles[0])
}
