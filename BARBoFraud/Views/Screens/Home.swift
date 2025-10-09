//
//  HomeScreen.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 22/09/25.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var router: Router
    @State private var showSideMenu = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color("AppBg").ignoresSafeArea()
            VStack(spacing: 0){
                TopBarView(title: "oFraud"){
                    withAnimation(.interactiveSpring(response: 0.35, dampingFraction: 0.8, blendDuration: 0.25)){
                        showSideMenu.toggle( )
                    }
                }
                FeedView()
            }
            if showSideMenu {
                HStack(spacing: 0){
                    SideMenuView(showMenu: $showSideMenu)
                        .frame(width: 300)
                        .transition(.move(edge: .leading))
                       
                    
                    Spacer()
                }
                .background(
                    Color.appBg.opacity(0.80)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showSideMenu.toggle()
                            }
                        }
                    )
                .transition(.move(edge: .leading))
            }
            
            if !showSideMenu {
                VStack {
                    Spacer()
                    NavigationBar()
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RootView()
}
