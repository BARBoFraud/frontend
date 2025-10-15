//
//  PostDTO.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import Foundation

struct Post : Decodable, Identifiable, Hashable {
    let name, lastName, image, url, website, socialMedia, username, email, phoneNumber : String?
    let id : Int
    let category, date, riskLevel, title, description : String
    let likeCount, commentCount, userLiked : Int
    
    enum CodingKeys: String, CodingKey {
        case id, category, name, lastName, title, riskLevel
        case date = "createdAt"
        case description, image, url, website, socialMedia, username, email, phoneNumber
        case likeCount = "likesCount"
        case commentCount = "commentsCount"
        case userLiked
    }
}

typealias Feed = [Post]
