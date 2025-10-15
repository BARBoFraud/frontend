//
//  ValidaCampos.swift
//  RegistroUsuario452
//
//  Created by Barbie on 22/08/25.
//

import Foundation

extension String {
    var esVacio: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var esPasswordValido: Bool {
        let pattern = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*\(\)\-_\+=\[\]\{\}\\|;:'",<\.>\/\?`~]).{10,}$"#
        return self.range(of: pattern, options: .regularExpression) != nil
    }
    var esCorreoValido: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
