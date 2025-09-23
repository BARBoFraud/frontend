//
//  Info.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI

struct Info: View {
    @State private var showSideMenu = false
    let articles: [ArticleDTO] = sampleArticles
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("AppBg").ignoresSafeArea()
                
                VStack(spacing: 0) {
                    TopBarView(title: "oFraud") {
                        showSideMenu.toggle()
                    }
                    
                    ScrollView() {
                        VStack(spacing: 18) {
                            VStack(alignment: .leading, spacing: 10) {
                                Spacer().frame(height: 20)
                                Text("En esta sección encontrarás una gran variedad de contenidos educativos y de actualidad sobre temas relacionados con la ciberseguridad.")
                                    .foregroundColor(Color("Text"))
                                    .font(.subheadline)
                                    .bold()
                                    .lineSpacing(4)
                                
                                Text("Estos artículos abordan desde noticias y tendencias en el ámbito de la ciberseguridad hasta guías prácticas y análisis de amenazas, con el objetivo de informar y educar a los lectores sobre cómo protegerse en el entorno digital.")
                                    .foregroundColor(Color("Text"))
                                    .font(.caption)
                                    .lineSpacing(4)
                            }
                            .padding(.horizontal)
                            
                            ForEach(articles) { article in
                                ArticleRow(article: article)
                                    .padding(.horizontal)
                            }
                            
                            Spacer(minLength: 24)
                        }
                        .padding(.top, 12)
                    }
                    
                }
            }
        }
        
        if showSideMenu {
            HStack(spacing: 0){
                SideMenuView(showMenu: $showSideMenu)
                    .frame(width: 250)
                    .transition(.move(edge: .leading))
                
                
                Spacer()
            }
            .background(
                Color.appBg
                    .ignoresSafeArea()
                    .onTapGesture {
                        showSideMenu.toggle()
                    }
                )
            .zIndex(1)
        }
    }
}





#Preview {
    Info()
}
