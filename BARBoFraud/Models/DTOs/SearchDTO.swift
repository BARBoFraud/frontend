//
//  SearchDTO.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 03/10/25.
//

import Foundation

struct SearchRequest : Encodable {
    let search: String
}

struct SearchResponse : Decodable, Identifiable {
    let id: Int
    let createdAt: String
    let title: String
    let riskLevel: String
    let category: String
}

struct SearchPost : Decodable, Identifiable {
    let id: Int
    let name: String?
    let lastName: String?
    let category: String
    let createdAt: String
    let riskLevel: String
    let title: String
    let description: String
    let image: String?
    let url: String?
    let website: String?
    let application: String?
    let username: String?
    let email: String?
    let phoneNumber: String?
    let likesCount: Int
    let commentsCount: Int
    let userLiked: Int
}
