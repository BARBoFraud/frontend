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
        switch post.category{
        case "Página de internet":
            return "\(post.website!): \(post.url!)"
        case "Llamada":
            return post.phoneNumber!
        case "Mensaje":
            return post.phoneNumber!
        case "Correo electrónico":
            return post.email!
        case "Red social":
            return post.username!
        default:
            return "otro"
        }
    }
    
    static func getActorHistory(from post: HistoryPostResponse) -> String {
        switch post.category{
        case "Página de internet":
            return post.url!
        case "Llamada":
            return post.phoneNumber!
        case "Mensaje":
            return post.phoneNumber!
        case "Correo electrónico":
            return post.email!
        case "Red social":
            return post.username!
        default:
            return "otro"
        }
    }
    
    static func getCategoryLabel(from category: String) -> String {
        switch category{
        case "Página de internet":
            return "Web"
        case "Llamada":
            return "Teléfono"
        case "Mensaje":
            return "Mensaje"
        case "Correo electrónico":
            return "email"
        case "Red social":
            return "Aplicación"
        default:
            return "otro"
        }
    }
    
    static func getLabelBackgroundColor(for cateogry: String) -> Color {
        switch cateogry {
        case "Página de internet":
            return Color(.teal)
        case "Red social":
            return Color(.cyan)
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
    
    static func getRiskLabelBackgroundColor(for risk: String) -> Color {
        switch risk {
        case "Alto":
            return Color(.red)
        case "Medio":
            return Color(.orange)
        case "Bajo":
            return Color(.yellow)
        default:
            return .gray
        }
    }
    
    static func getStatusLabelBackgroundColor(for status: String) -> Color {
        switch status {
        case "Aceptado":
            return Color(red: 37/255, green: 211/255, blue: 102/255)
        case "Pendiente":
            return Color(.yellow)
        case "Rechazado":
            return Color(.red)
        default:
            return .gray
        }
    }
}
