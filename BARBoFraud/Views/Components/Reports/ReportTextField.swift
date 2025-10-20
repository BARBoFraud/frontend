//
//  ReportTextField.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/18.
//

import SwiftUI

enum FieldType{
    case singleLine
    case multiLine
}

struct ReportTextField: View {
    @State var isExpanded: Bool = true
    @Binding var text: String
    
    var label: String = ""
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var fieldType: FieldType = .singleLine
    var autoCap: Bool = false
    
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
                        .animation(.easeIn(duration: 0.2), value: isExpanded)
                }
                .buttonStyle(.plain)
                .foregroundColor(.text)
            
                Text(label)
                    .font(.title2)
                    .bold()
                Spacer()
            }.padding(.bottom, 10)
            
            if isExpanded {
                if fieldType == .singleLine {
                    TextField(placeholder, text: $text)
                        .autocapitalization(autoCap ? .sentences : .none)
                        .keyboardType(keyboardType)
                        .font(.system(size: 20, weight: .medium))
                        .padding(.horizontal, 12)
                        .background(.white.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal, 0.1)
                }else{
                    ZStack(alignment: .topLeading){
                        if text.isEmpty {
                            Text(placeholder)
                                .autocapitalization(autoCap ? .sentences : .none)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.gray.opacity(0.5))
                                .padding(.horizontal, 8)
                                .cornerRadius(10)
                                .padding(.top, 10)
                        }
                        TextEditor(text: $text)
                            .keyboardType(.default)
                            .frame(height: 100)
                            .padding(4)
                            .background(.white.opacity(0.3))
                            .cornerRadius(10)
                            .scrollContentBackground(.hidden)
                    }
                    
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color.accentColor, lineWidth: 1)
                .fill(.appBg)
        )
    }
}

#Preview {
    NewReport()
}
