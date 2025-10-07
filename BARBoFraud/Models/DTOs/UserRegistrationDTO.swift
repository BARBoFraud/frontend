//
//  UserRegistrationDTO.swift
//  RegistroUsuario452
//
//  Created by Barbie on 29/08/25.
//

import Foundation

struct RegistrationFormRequest:Codable {
    var name: String
    var lastName1: String
    var lastName2: String
    var email: String
    var password: String
}
