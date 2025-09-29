//
//  EnterURL.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 22/09/25.
//

import SwiftUI

struct EnterURL: View {
    @State private var expanded: Bool = true
    @Binding var url: String
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
                Text("URL de la página")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                    .padding(.horizontal, 20)
                Spacer()
            }
            
            if expanded {
                TextField("Nombre", text: $url)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.horizontal, 12)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 0.1)
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
        @State var url: String = ""
        @State var nextStep: Bool = false
        
        var body: some View {
            EnterURL(url: $url, nextStep: $nextStep)
            }
        }
    return prev()
}
