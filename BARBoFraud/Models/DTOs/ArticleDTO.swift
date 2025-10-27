//
//  ArticleDTO.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI


import SwiftUI

struct ArticleDTO: Identifiable, Equatable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let content: String
    let imageName: String?
    let author: String
    let date: String
    let link: URL?
}

let autores = ["Laura Martínez"]

let articleURL = AppConfig.articleURLs

let sampleArticles: [ArticleDTO] = [
    ArticleDTO(
        title: "La importancia de la educación tecnológica",
        description: """
        Actualmente la tecnología ha llegado para quedarse y somos testigos de todos los avances que ha tenido, para mejorar nuestra vida cotidiana, y con la llegada delSARS-CoV-2, revolucionó por completo el uso de estas herramientas y en el ámbito de la educación no fue la excepción.
        """,
        content: """
        Los métodos de enseñanza tuvieron que enfrentar grandes cambios que en un principio causaron incertidumbre entre los docentes y alumnos, ya que desde hace mucho tiempo el aprendizaje en modalidad presencial era el único que conocíamos, teniendo dudas en cómo podría afectar el rendimiento académico de los estudiantes si este cambiaba.
        Y aunque al principio pudo representar un reto para muchos, al menos para los niños y jóvenes resulto en una rápida adaptación, ya que al crecer rodeados de toda esta tecnología solo era cuestión de tiempo que exploraran estas posibilidades y así permitir que el aprendizaje se volviera más fácil y cómodo.
        La educación tecnológica se refiere a la capacitación o al conocimiento que cada usuario desea adquirir, esto con ayuda de un dispositivo tecnológico para que el usuario comprenda ¿para qué sirve?, ¿Cuáles son sus necesidades? y ¿Cómo utilizar la tecnología a su favor?. Cada usuario debe comprender las especificaciones de la tecnología que se le proporciona.
        Beneficios
        Incorporar herramientas tecnológicas en la educación aporta beneficios que promueven el conocimiento y la interacción, además de la eficiencia y la productividad tanto en docentes como estudiantes.
        1. Fomenta la colaboración
        La necesidad de relacionarse y expresarse brinda grandes oportunidades de comunicación con los compañeros y con la tecnología facilita los trabajos en grupo, así como el acceso a herramientas digitales para una mejor comunicación y gestión de tareas.
        2. Exploración de nuevos conocimientos
        La curiosidad es algo natural en todo ser humano y en un estudiante es todavía más, es por eso que, la adopción de la tecnología es importante, ya que ahora se cuenta con bibliotecas digitales y contenido audiovisual disponible las 24 horas del día, permitiendo abordar diferentes temas de una manera rápida y sencilla.
        3. Facilita la comprensión
        El uso de plataformas digitales como Microsoft Teams, Zoom o Google Meet permite que las clases sean más dinámicas posibilitando que los alumnos puedan consultar sus dudas cuando lo deseen, esto gracias a las herramientas que brindan las plataformas digitales, tales como la grabación de la reunión e incluso adjuntando material extra en la sección de comentarios.
        4. Brinda autonomía
        Desarrolla la capacidad de los alumnos para realizar por sí mismos todas aquellas tareas que se les encomienda en el aula virtual ya sea controlando y estableciendo rutinas de estudio e incluso implementando nuevas técnicas de aprendizaje, esto gracias a las plataformas de aprendizaje en la web o las herramientas de planeación como lo pueden ser Google ClassRoom o Microsoft Planner.
        5. Impulsa la creatividad
        Brinda esa originalidad de visión e iniciativa con el fin de hacer más llevadero su proceso de aprendizaje de una manera divertido para los alumnos como por ejempló en la producción de videos, presentaciones, animaciones u otro tipo de trabajos artísticos que se puedan crear a través de los dispositivos móviles.
        """,
        imageName: "art1",
        author: autores[0],
        date: "diciembre 21, 2022",
        link: URL(string: articleURL[0])
    ),
    ArticleDTO(
        title: "¿A cuánto se venden los datos personales en internet?",
        description: """
        ¿Sabías que el compartir una foto en redes sociales hasta el navegar en la web, deja un rastro de información personal? Pues a esto se le conoce como huella digital y mientras más cuentas en línea tenga un usuario o más navegue en internet, su huella digital aumenta.
        """,
        content: """
        Como usuarios, la mayoría de las veces no somos conscientes de la importancia de nuestra privacidad en internet, esto porque al momento de utilizar la tecnología para cada aspecto de nuestros días, nos permitimos en muchas ocasiones, incluso sin saberlo, publicar datos de los cuales podrían verse comprometidos y terminen por caer en manos no deseadas, teniendo como propósito el uso y venta ilegal de nuestra privacidad.
        Datos Personales
        ¿Qué son?
        Los datos personales son toda aquella información que se relaciona con nuestra persona y que nos identifica.
         
        Edad.
        Género.
        Domicilio.
        Número telefónico.
        Correo electrónico.
        Trayectoria académica, laboral o profesional.
        Patrimonio.
        Número de seguridad social.
        CURP.
        Entre otros.
        ¿En cuánto se venden?
        Al menos en México, de acuerdo con cifras del Instituto Nacional al Acceso a la Información y Protección de Datos (INAI) están entre $132 a $235 MXN.
         
        Solo para que te des una idea de cuánto valen tus datos personales, el INAI reveló el precio de ciertos datos:
         
        Nombre completo: $203 MXN.
        Fecha de nacimiento: $162 MXN.
        Lugar de nacimiento: $143 MXN.
        Número de teléfono: $220 MXN.
        Firma electrónica: $235 MXN.
        *Datos obtenidos de la página oficial de Facebook del INAI*
         
        Estos datos les dan a los cibercriminales el acceso a la vida de una persona, brindándoles la oportunidad de usurpar una identidad y cometer fraudes de diversa índole a tu nombre.
        Más valorados
        Como podemos imaginar, los datos financieros son los más codiciados, aunque eso no significa que debamos enfocarnos en estos, ya que para un cibercriminal, todo lo que pueda obtener es de gran ventaja.
         
         
        Datos de la tarjeta de débito – $1,493.25 MXN.
        Cuentas de PayPal – $6,054 MXN.
        Cuentas de Amazon – $222 MXN.
        Las ID en Apple, Steam y Spotify – $202 MXN.
        Datos en las redes sociales – Rondan entre los $96 a $121 MXN.
        Aplicaciones que recaban mayor cantidad de datos personales
        Instagram: 58.82% de datos personales recabados.
        Facebook: 70% de datos personales recabados.
        Spotify: 35.29% de datos personales recabados.
        Netflix: 26.47% de datos personales recabados.
        Amazon: 23.53% de datos personales recabados.
        """,
        imageName: "art2",
        author: autores[0],
        date: "junio 22, 2023",
        link: URL(string: articleURL[1])
    ),
ArticleDTO(
        title: "¿Cómo lidiar ante una extorsión online?",
        description: """
        La extorsión por internet es la manera de pedir un “rescate por su información” extraída mediante un malware por otra persona, es decir, un programa informático malicioso es infiltrado en su computadora, esto para que previamente se solicite un pago o alguna otra demanda para recuperar dicha información robada.
        """,
        content: """
        Un malware puede ser contraído por varias razones, un ejemplo es por la descarga de algún archivo de fuentes no confiables, por la instalación de algún software gratuito que ya está infectado, visitando sitios web maliciosos, dando clic a algún enlace y/o provocando la entrada a un malware.
         
        Todo tipo de dispositivo electrónico es propenso a una infección de este tipo, como un teléfono móvil, una computadora, una tableta, incluso una consola de videojuegos, si el dispositivo tiene acceso a internet es vulnerable a un ataque cibernético.
        ¿Qué tipos de extorsión existen?
        Es muy importante tener cuidado a que le damos clic, existe mucho mal, entre las diversas extorsiones online más famosas están:
        Grooming
        Es un acoso y abuso sexual, el llamado “Engaño pederasta”. Son acciones de un adulto a través de internet para engañar a una persona menor de edad con fines sexuales.
         
        La persona menor de edad es extorsionada para acceder a demandas sexuales, estas aumentan bajo la amenaza de revelar dicho contenido.
         
        Los atacantes son pedófilos o pederastas que se acercan al menor por un medio de comunicación en internet, estableciendo un vínculo emocional para conseguir fotográficas o videos, o robando directamente fotografías.
        Engaño por sharenting
        El sharenting es una acción por parte de la figura paterna y materna al compartir información de sus hijos en redes sociales, no tiene una intención maliciosa, al contrario, la intención de los padres es para compartir la “emoción” y lo “orgullosos” que están de sus hijos, sin embargo, esta acción tiene una responsabilidad, en primera no sabes si tus hijos están de acuerdo, en segundo lugar, la mayoría de los niños todavía no comprenden nada de lo que publican.
         
        Es probable que esté haciendo que su hijo tenga un futuro vulnerable a un fraude, un robo de contraseñas, incluso a un riesgo financiero, pero no es el único riesgo, al tener tantas fotos e información en la red, una persona externa podría hacerse pasar por amigos cercanos, familia del menor para engañar a una persona.
        Sexting
        Como su nombre lo indica, trata sobre contenido sexual, en el que dos personas intercambian videos o fotos sexuales, y una parte amenaza con mostrarlas al público, a amigos o familia con la intención de conseguir algo.
        Ransomware
        Este tipo de malware impide que un usuario acceda a su sistema operativo o algún(os) archivo personal, para después solicitar un rescate para acceder de nuevo a ellos.
        """,
        imageName: "art3",
        author: autores[0],
        date: "junio 23, 2023",
        link: URL(string: articleURL[2])
    )

]

