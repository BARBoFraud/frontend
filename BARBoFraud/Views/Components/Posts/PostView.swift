//
//  Post.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import SwiftUI

struct PostView: View {
    
    @EnvironmentObject var router: Router
    
    var post: Post

    var body: some View {
        switch post.category {
        case "Correo electrónico" :
            Text("\(post.category)")
        case "Llamada" :
            PhonePostView(post: post)
        case "Mensaje" :
            Text("\(post.category)")
        case "Página de internet" :
            WebPostView(post: post)
        case "Red social" :
            SocialMediaPostView(post: post)
        default:
            Text("Error al cargar el reporte")
        }
    }
}

#Preview{
    RootView()
}
