//
//  EnterURL.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 22/09/25.
//

import SwiftUI

struct EnterURL: View {
    @State private var isExpanded: Bool = false
    @Binding var url: String
    
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
                        .rotationEffect(.degrees(isExpanded ? 0 : -90))
                        .animation(.easeInOut(duration: 0.25), value: isExpanded)
                }
                .buttonStyle(.plain)
                .foregroundColor(.text)
            
                Text("URL de la página")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            if isExpanded {
                TextField("URL", text: $url)
                    .keyboardType(.URL)
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
        @State var url: String = ""
        
        var body: some View {
            EnterURL(url: $url)
            }
        }
    return prev()
}
