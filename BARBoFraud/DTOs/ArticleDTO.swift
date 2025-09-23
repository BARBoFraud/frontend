//
//  ArticleDTO.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI

struct ArticleDTO: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String?
}
let sampleArticles: [ArticleDTO] = [
    ArticleDTO(
        title: "La importancia de la educación tecnológica",
        description: """
        Actualmente la tecnología ha llegado para quedarse y somos testigos de todos los avances que ha tenido, para mejorar nuestra vida cotidiana, y con la llegada delSARS-CoV-2, revolucionó por completo el uso de estas herramientas y en el ámbito de la educación no fue la excepción.
        """,
        imageName: "art1"
    ),
    ArticleDTO(
        title: "¿A cuánto se venden los datos personales en internet?",
        description: """
        ¿Sabías que el compartir una foto en redes sociales hasta el navegar en la web, deja un rastro de información personal? Pues a esto se le conoce como huella digital y mientras más cuentas en línea tenga un usuario o más navegue en internet, su huella digital aumenta.
        """,
        imageName: "art2"
    )
]



