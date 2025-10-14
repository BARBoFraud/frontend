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
    private var routes: [Route] = []
    
    func push(_ route: Route) {
        if (routes.last != route) {
            routes.append(route)
            path.append(route)
        }
    }
    
    func reset(to route: Route) {
        routes = [route]
        path = NavigationPath([route])
    }
    
    func pop() {
        routes.removeLast()
        path.removeLast()
    }
    
    func clear() {
        path = NavigationPath()
    }
}
