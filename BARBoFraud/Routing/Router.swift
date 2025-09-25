//
//  Router.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 25/09/25.
//
import SwiftUI
import Foundation

final class Router : ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func reset(to route: Route) {
        path = NavigationPath([route])
    }
    
    func pop() {
        path.removeLast()
    }
    
    func clear() {
        path = NavigationPath()
    }
}
