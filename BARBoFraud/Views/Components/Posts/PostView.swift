//
//  Post.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct PostView: View {
    
    @EnvironmentObject var router: Router
    
    var post : Post

    var body: some View {
        switch post.category {
        case "Correo electrónico" :
            Text("\(post.category)")
        case "Llamada" :
            Text("\(post.category)")
        case "Mensaje" :
            Text("\(post.category)")
        case "Página de internet" :
            VStack(alignment: .leading, spacing: 12) {
                HStack{
                    if post.name != ""{
                        Text("\(post.name) \(post.lastName)")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Spacer()
                    Text("web")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text(post.website)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(post.url)
                    .font(.system(size: 20, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .center)

                Image(post.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                        .clipped()
                        .cornerRadius(10)
                
                Text(post.description)
                    .font(.system(size: 16, weight: .regular))
                Text(post.date)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.gray)
                
                //Comentarios y likes
                HStack(spacing: 100) {
                    CommentButton(initialCount: post.commentCount)
                    LikeButton(initialCount: post.likeCount, initiallyLiked: post.userLiked == 1)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.subheadline)
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)
            .contentShape(Rectangle()) // Makes entire card tappable
            .onTapGesture {
                router.push(.postDetail(post))
            }
        case "Red social" :
            VStack(alignment: .leading, spacing: 12) {
                HStack{
                    if post.name != ""{
                        Text("\(post.name) \(post.lastName)")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    Spacer()
                    Text("\(post.socialMedia)")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(labelBackgroundColor(for: post.socialMedia))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text(post.username)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)

                Image(post.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                        .clipped()
                        .cornerRadius(10)
                
                Text(post.description)
                    .font(.system(size: 16, weight: .regular))
                Text(post.date)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.gray)
                
                //Comentarios y likes
                HStack(spacing: 100) {
                    CommentButton(initialCount: post.commentCount)
                    LikeButton(initialCount: post.likeCount, initiallyLiked: post.userLiked == 1)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.subheadline)
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)
            .contentShape(Rectangle()) // Makes entire card tappable
            .onTapGesture {
                router.push(.postDetail(post))
            }
        default:
            Text("Error al cargar el reporte")
        }
    }
}
    
func labelBackgroundColor(for socialMedia: String) -> Color {
    switch socialMedia {
    case "Instagram":
        return .pink
    case "TikTok":
        return .purple
    case "Whatsapp":
        return .green
    case "Facebook":
        return .blue
    case "Twitter":
        return .black
    default:
        return .gray
    }
}

#Preview{
    RootView()
}
