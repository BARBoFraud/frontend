//
//  RegisterErrors.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 23/10/25.
//

import Foundation

enum AuthenticationError: Error {
    case network(NetworkError)
    case register(RegisterError)
    case unknown(Error)
}
