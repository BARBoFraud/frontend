//
//  UserProfile.swift
//  RegistroUsuario452
//
//  Created by Barbie on 12/09/25.
//

import Foundation

struct Profile: Decodable {
    let id: Int
    let email, name, lastName1, lastName2: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, lastName1, lastName2
    }
}

struct UpdateProfile: Encodable {
    let name, lastName1, lastName2, email: String
}
