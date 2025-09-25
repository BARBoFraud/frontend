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
        print("\n\n\n\nCurrent path: \(path)")
    }
    
    func reset(to route: Route) {
        routes = [route]
        path = NavigationPath([route])
        print("\n\n\n\nCurrent path: \(path)")
    }
    
    func pop() {
        routes.removeLast()
        path.removeLast()
        print("\n\n\n\nCurrent path: \(path)")
    }
    
    func clear() {
        path = NavigationPath()
    }
}
