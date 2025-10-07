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
            if !email.esCorreoValido{
                errors.append("El correo no es valido")
            }
            if !pass.esPasswordValido{
                errors.append("La contraseña no cumple con el requerimiento de 3 caracteres")
            }
            return errors
            
        }
    }
}
