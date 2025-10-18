//
//  SocialNetwork.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 09/10/25.
//

import SwiftUI

enum socialMedia {
    case facebook
    case instagram
    case twitter
    case tiktok
    case snapchat
    case linkedin
}

enum messagingApps{
    case Whatsapp
    case Telegram
    case SMS
    case Messenger
}


struct Application: View {
    @State private var isExpanded: Bool = true
    @Binding var application: String
    
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
                
                Text("Red social")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            
            if isExpanded {
                TextField("Red social", text: $application)
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
        @State var application: String = ""
        
        var body: some View {
            Application(application: $application)
        }
    }
    return prev()
}
