//
//  RegisterError.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 23/10/25.
//

import Foundation

enum RegisterError: Error, LocalizedError {
    case UserAlreadyRegistered
    
    var errorDescription: String? {
        switch self {
        case .UserAlreadyRegistered:
            return "El correo ya está registrado."
        }
    }
}
