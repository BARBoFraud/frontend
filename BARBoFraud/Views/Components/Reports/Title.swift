//
//  Title.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/17.
//

import SwiftUI

struct Title: View {
    @State private var isExpanded: Bool = true
    @Binding var title: String
    
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
                .buttonStyle(.plain)
                .foregroundColor(.text)
            
                Text("Título del reporte")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            if isExpanded {
                TextField("Título", text: $title)
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
        @State var title: String = ""
        
        var body: some View {
            Title(title: $title)
            }
        }
    return prev()
}
