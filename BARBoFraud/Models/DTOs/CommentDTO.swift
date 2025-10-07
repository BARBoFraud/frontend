//
//  CommentDTO.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import Foundation

struct CommentResponse : Decodable {
    let comment : Comment
}

struct Comment : Decodable, Identifiable {
    let id : Int
    let firstName, lastName, commentText: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case commentText = "comment_text"
    }
}

