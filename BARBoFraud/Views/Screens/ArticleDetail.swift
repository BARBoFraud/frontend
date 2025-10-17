//
//  ArticleDetailView.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI

struct ArticleDetail: View {
    @Environment(\.openURL) var openURL
    
    let article: ArticleDTO
    let articles: [ArticleDTO] = sampleArticles
    
    var body: some View {
        VStack(spacing: 0) {
            ViewHeader(title: "Artículo")
            
            Divider().opacity(0.2)
            
            ScrollView {
                VStack(spacing: 18) {
                    if let imageName = article.imageName {
                        ZStack(alignment: .bottom) {
                            Image(imageName)
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
                        .shadow(color: Color.black.opacity(0.25), radius: 3, x: 0, y: 6)
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
                        
                        Text(article.content)
                            .font(.body)
                            .foregroundColor(Color("Text"))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(6)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if let link = article.link {
                            Button(action: {
                                openURL(link)
                            }) {
                                HStack {
                                    Image(systemName: "link")
                                    Text("Leer artículo completo")
                                        .underline()
                                }
                                .font(.subheadline.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }

                    } 
                    .frame(width: 330)
                    .padding()
                    
                    Spacer(minLength: 24)
                }
                .padding(.top, 12)
            }
            .background(Color("AppBg").ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ArticleDetail(article: sampleArticles[0])
}
