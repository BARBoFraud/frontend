//
//  SignUpExtention.swift
//  BARBoFraud
//
//  Created by Barbie on 25/09/25.
//

import Foundation

extension SignUp {
    struct UserRegistrationForm{
        var name: String = ""
        var lastName1: String = ""
        var lastName2: String = ""
        var email: String = ""
        var password: String = ""
        var passwordConfirmation: String = ""
        
        func validate() -> [String] {
            var errors: [String] = []
            if name.esVacio{
                errors.append("El nombre es requerido")
            }
            if lastName1.esVacio{
                errors.append("El apellido paterno es requerido")
            }
            if lastName2.esVacio{
                errors.append( "El apellido materno es requerido")
            }
            if email.esVacio{
                errors.append("El correo es requerido")
            }
            if password.esVacio{
                errors.append("La contraseña es requerida")
            }
            if passwordConfirmation.esVacio{
                errors.append("La contraseña de confirmación es requerida")
            }
            if password != passwordConfirmation{
                errors.append("Las contraseñas no coinciden")
            }
            if !email.esCorreoValido{
                errors.append("El correo no es valido")
            }
            if !password.esPasswordValido{
                errors.append("La contraseña no cumple con el requerimiento de 3 caracteres")
            }
            return errors
            
        }
    }
}
