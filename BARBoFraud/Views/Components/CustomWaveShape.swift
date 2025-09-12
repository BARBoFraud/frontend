//
//  CustomWaveShape.swift
//  wavy_background
//
//  Created by Jorge Cadena on 22/08/25.
//

import SwiftUI

struct CustomWaveShape: Shape {
    var phase: CGFloat
    var strength: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        
        for x in stride(from: 0, through: rect.width, by: 1) {
            let relativeX = x / rect.width
            let y = rect.height / 2
                + sin(relativeX * 2 * .pi + phase) * strength
                + cos(relativeX * 4 * .pi + phase) * (strength / 3)
            
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}
