//
//  RefreshDTO.swift
//  BARBoFraud
//
//  Created by Barbie on 13/10/25.
//

import Foundation

struct RefreshRequest: Codable {
    let refreshToken: String
}

struct RefreshResponse: Decodable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
    }
}
