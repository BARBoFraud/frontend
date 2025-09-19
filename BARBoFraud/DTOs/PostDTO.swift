//
//  PostDTO.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/19.
//

import Foundation

struct PostResponse : Decodable {
    let post : Post
}

struct Post : Decodable {
    let firstName, lastName, title, postText : String
    let image : Data?
    let date : Date
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case postText = "post_text"
        case title, image, date
        
    }
}
