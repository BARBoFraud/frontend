//
//  PostDTO.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import Foundation

typealias Feed = [Post]

struct Post : Decodable, Identifiable, Hashable {
    let name, lastName, image, url, website, application, username, email, phoneNumber : String?
    let id : Int
    let category, date, riskLevel, title, description : String
    let likeCount, commentCount, userLiked : Int
    
    enum CodingKeys: String, CodingKey {
        case id, category, name, lastName, title, riskLevel
        case date = "createdAt"
        case description, image, url, website, application, username, email, phoneNumber
        case likeCount = "likesCount"
        case commentCount = "commentsCount"
        case userLiked
    }
}

struct PostUpdate : Encodable {
    let categoryId: Int
    let title, description: String
    let url, website, application, phoneNumber, username, email, imageId: String?
    let anonymous: Bool
}
