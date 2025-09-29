//
//  PageName.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 28/09/25.
//

import SwiftUI

struct PageName: View {
    @State private var expanded: Bool = true
    @Binding var pageName: String
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
                Text("Nombre página")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                    .padding(.horizontal, 20)
                Spacer()
            }
            if expanded {
                TextField("Nombre", text: $pageName)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.horizontal, 12)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                HStack {
                    Spacer()
                    Button("Siguiente", action: {
                        withAnimation{
                            expanded = false
                            nextStep = true
                        }
                    })                    .background(
                        Rectangle()
                            .foregroundColor(.blue)
                            .cornerRadius(19)
                            .frame(width: 85)
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
        @State var pageName: String = ""
        @State var nextStep: Bool = false
        
        var body: some View {
            PageName(pageName: $pageName, nextStep: $nextStep)
            }
        }
    return prev()
}
