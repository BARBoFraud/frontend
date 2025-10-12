//
//  Email.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 10/10/25.
//

import SwiftUI

struct Email: View {
    @State private var expanded: Bool = true
    @Binding var email: String
    
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
                Text("Correo electrónico")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 8)
                    .padding(.horizontal, 20)
                Spacer()
            }
            
            if expanded {
                TextField("example@gmail", text: $email)
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
                .stroke(Color.blue, lineWidth: 3)
                .frame(width: 300)
        )
        .frame(width: 300)
    }
}

#Preview {
    struct prev: View {
        @State var email: String = ""
        
        var body: some View {
            Email(email: $email)
            }
        }
    return prev()
}
