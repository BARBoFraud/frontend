//
//  Description.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 29/09/25.
//

import SwiftUI

struct Description: View {
    @State private var isExpanded: Bool = true
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    withAnimation{
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .frame(width: 20, height: 12)
                        .rotationEffect(.degrees(isExpanded ? -90 : 0))
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                }
                .foregroundColor(.text)
                
                Text("Descripción estafa")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            if isExpanded {
                TextField("Desciproción del fraude", text: $description)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.horizontal, 12)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 0.1)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color.accentColor, lineWidth: 1)
                .frame(width: 300)
        )
        .frame(width: 300)
    }
}

#Preview {
    struct prev: View {
        @State var description: String = ""
        
        var body: some View {
            Description(description: $description)
            }
        }
    return prev()
}
