//
//  CategoryIDController.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 10/10/25.
//

import Foundation

struct CategoryIDController {
    let httpClient: HTTPClientCategoryID
    func getCategoryID() async throws -> [IDCategoryRequest] {
        try await httpClient.getCategoryID()
    }
}
