//
//  PageName.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 28/09/25.
//

import SwiftUI

struct PageName: View {
    @State private var isExpanded: Bool = false
    @Binding var pageName: String
    
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
                
                Text("Nombre página")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            if isExpanded {
                TextField("Nombre", text: $pageName)
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
        @State var pageName: String = ""
        
        var body: some View {
            PageName(pageName: $pageName)
            }
        }
    return prev()
}
