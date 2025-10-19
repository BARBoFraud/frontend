//
//  IDCategoryDTO.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 10/10/25.
//

import Foundation

struct IDCategoryRequest: Decodable {
    var id: Int
    var name: String
}

struct CategoryIdResponse: Decodable {
    let id: Int
}
