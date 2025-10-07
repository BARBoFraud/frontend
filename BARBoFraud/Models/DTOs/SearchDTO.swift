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
    let website: String?
    let socialMedia: String?
    let email: String?
    let phoneNumber: String?
}
