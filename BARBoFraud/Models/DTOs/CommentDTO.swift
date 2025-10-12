//
//  CommentDTO.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import Foundation

typealias Comments = [CommentResponse]

struct CommentRequest : Encodable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "content"
    }
}

struct CommentResponse : Decodable {
    let id: Int
    let text, date: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case text = "content"
        case date = "createdAt"
        case username
    }
}
