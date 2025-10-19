//
//  ApplicationField.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 09/10/25.
//

import SwiftUI

let socialMedia: [String] = ["Facebook", "Instagram", "Twitter/X", "Tik Tok", "Snapchat", "LinkedIn", "Temu", "Alibaba"]

let messagingApps: [String] = ["WhatsApp", "Telegram", "SMS", "Facebook Messenger"]

enum AppType {
    case socialMedia
    case messageApp
}

struct ApplicationField: View {
    @State private var isExpanded: Bool = true
    @Binding var application: String
    
    var title: String = ""
    var appType: AppType = .socialMedia
    
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
                .foregroundColor(.text)
                
                Text(title)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            if isExpanded {
                let app = (appType == .socialMedia) ? socialMedia : messagingApps
                ForEach(app.indices, id: \.self){ index in
                    Button(action: {
                        application = app[index]
                        isExpanded = false
                    }) {
                        HStack() {
                            Image(systemName: application == app[index] ? "largecircle.fill.circle" : "circle")
                                .foregroundColor(application == app[index] ? .text : .gray)
                                .font(.system(size: 20))
                            Text(app[index])
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                    }.buttonStyle(.plain)
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
