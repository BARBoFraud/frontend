//
//  PostUtils.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/12.
//

import Foundation
import SwiftUICore

struct PostUtils{

    static func getActor(from post: Post) -> String{
        print(post.category)
        switch post.category{
        case "Página de internet":
            return post.website
        case "Red social":
            return post.username
        case "Llamada":
            return post.phoneNumber
        case "Mensaje":
            return post.phoneNumber
        case "Correo Electrónico":
            return post.email
        default:
            return ""
        }
    }
    
    static func getCategoryLabel(from category: String) -> String {
        switch category{
        case "Página de internet":
            return "Página web"
        case "Llamada":
            return "Teléfono"
        case "Mensaje":
            return "Mensaje"
        case "Correo Electrónico":
            return "email"
        default:
            return "otro"
        }
    }
    
    static func getLabelBackgroundColor(for cateogry: String) -> Color {
        switch cateogry {
        case "Página de internet":
            return Color(.teal)
        case "Llamada":
            return Color(.green)
        case "Whatsapp":
            return Color(red: 37/255, green: 211/255, blue: 102/255)
        case "Telegram":
            return Color(.cyan)
        case "SMS":
            return Color(.green)
        case "Correo Electrónico":
            return Color(.blue)
        case "Instagram":
            return Color(red: 225/255, green: 48/255, blue: 108/255)
        case "TikTok":
            return .black
        case "Twitter/X":
            return .teal
        case "Facebook":
            return Color(red: 24/255, green: 119/255, blue: 242/255)
        default:
            return .gray
        }
    }
}
