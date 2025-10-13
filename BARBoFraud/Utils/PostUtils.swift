//
//  PostUtils.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/12.
//

import Foundation

struct PostUtils{

    static func unwrapPost(from post: Post) -> (title: String, actor: String){
        var actor : String = ""
        var title : String = ""
        switch post.category{
        case "Página de internet":
            title = post.url
        case "Red social":
            if post.socialMedia == "Whatsapp"{ title = "\(post.socialMedia) \(post.phoneNumber)"}
            else if post.socialMedia == "Facebook" {title = "\(post.socialMedia) \(post.username)"}
            else{ title = "\(post.socialMedia) @\(post.username)"}
                    
            
        case "Llamada":
            title = post.phoneNumber
        case "Mensaje":
            title = post.phoneNumber
        case "Correo electrónico":
            title = post.email
        default:
            print("Invalid Category")
        }
        return (title, actor)
    }
}
