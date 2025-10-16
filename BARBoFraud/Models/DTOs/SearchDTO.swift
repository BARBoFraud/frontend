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
