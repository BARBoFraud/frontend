//
//  Description.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 29/09/25.
//

import SwiftUI

struct Description: View {
    @State private var expanded: Bool = true
    @Binding var description: String
    @Binding var nextStep: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Button(action: {
                    withAnimation{
                        expanded.toggle()
                    }
                }) {
                    Image(systemName: expanded ? "chevron.right" : "chevron.down")
                        .font(.title2)
                }
                .foregroundColor(.text)
                Spacer()
                Text("Descripción estafa")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                    .padding(.horizontal, 20)
                Spacer()
            }
            
            if expanded {
                TextField("Desciproción del fraude", text: $description)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.horizontal, 12)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 0.1)
                
                HStack {
                    Spacer()
                    Button("Enviar reporte", action: {
                        withAnimation{
                            expanded = false
                            nextStep = true
                        }
                    })                    .background(
                        Rectangle()
                            .foregroundColor(.blue)
                            .cornerRadius(19)
                            .frame(width: 120)
                    )
                    .foregroundStyle(.text)
                    .padding(.top,8)
                    Spacer()
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color.blue, lineWidth: 3)
                .frame(width: 300)
        )
        .frame(width: 300)
    }
}

#Preview {
    struct prev: View {
        @State var description: String = ""
        @State var nextStep: Bool = false
        
        var body: some View {
            Description(description: $description, nextStep: $nextStep)
            }
        }
    return prev()
}
