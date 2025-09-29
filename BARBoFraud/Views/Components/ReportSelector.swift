//
//  ReportSelector.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 21/09/25.
//

import SwiftUI

struct ReportSelector: View {
    //let fraudTypes: [String]
    @Binding var selectedType: String
    
    @State private var expanded: Bool = true
    
    let options = ["Página de internet", "Red social", "Mensaje", "Llamada", "Correo electrónico"]
    
    var body: some View {
        ZStack {
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
                    Text("Tipo de fraude")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 8)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                if expanded {
                    ForEach(options, id: \.self) { type in
                        Button(action: {
                            selectedType = type
                            withAnimation {
                                expanded = false
                            }
                        }) {
                            HStack() {
                                // Radio button simple
                                Image(systemName: selectedType == type ? "largecircle.fill.circle" : "circle")
                                    .foregroundColor(selectedType == type ? .blue : .gray)
                                    .font(.system(size: 20))
                                
                                Text(type)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 25)
                        }
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
}

#Preview {
    ReportSelector(selectedType: .constant("Pagina de Internet"))
}
