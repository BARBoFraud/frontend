//
//  ArticleRow.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI
struct ArticleRow: View {
    let article: ArticleDTO
    @State private var navigate = false
    
    var body: some View {
        ZStack {
            ArticleCardView(article: article) {
                navigate = true
            }
            NavigationLink(destination: ArticleDetail(article: article), isActive: $navigate) {
                EmptyView()
            }
            .hidden()
        }
    }
}



