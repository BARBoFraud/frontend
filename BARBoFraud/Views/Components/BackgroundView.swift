//
//  BackgroundView.swift
//  oFraud_Equipo8
//
//  Created by Usuario on 22/09/25.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("Waves"), Color("AppBg")],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            CustomWaveBackground()
            
            content
        }
    }
}





#Preview {
    BackgroundView{
        VStack{}
    }
}
