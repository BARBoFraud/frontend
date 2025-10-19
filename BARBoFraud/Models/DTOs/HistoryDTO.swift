//
//  HistoryDTO.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 15/10/25.
//

import Foundation

struct HistoryResponse: Decodable, Identifiable {
    let id: Int
    let title: String
    let createdAt: String
    let category: String
    let status: String
}

struct HistoryPostResponse: Decodable, Identifiable {
    let id: Int
    let title, description, createdAt, category, status: String
    let url, website, application, phoneNumber, username, email, image: String?
}
