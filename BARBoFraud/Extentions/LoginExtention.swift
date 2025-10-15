//
//  LoginExtention.swift
//  BARBoFraud
//
//  Created by Barbie on 25/09/25.
//

import Foundation

extension LogIn {
    struct LoginForm{
        var email: String = ""
        var pass: String = ""
        
        func validate() -> [String] {
            var errors: [String] = []

            if email.esVacio{
                errors.append("El correo es requerido")
            }
            if pass.esVacio{
                errors.append("La contraseña es requerida")
            }
            return errors
        }
    }
}
