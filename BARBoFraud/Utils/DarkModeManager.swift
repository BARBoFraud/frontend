//
//  DarkModeManager.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/10/25.
//

import SwiftUI

@MainActor
class DarkModeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
}
