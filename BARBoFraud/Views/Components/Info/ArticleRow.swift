//
//  ArticleRow.swift
//  BARBoFraud
//
//  Created by Barbie on 23/09/25.
//

import SwiftUI
struct ArticleRow: View {
    let article: ArticleDTO
    @EnvironmentObject var router: Router
//    @State private var navigate = false
    
    var body: some View {
        ZStack {
            ArticleCardView(article: article) {
                router.push(.articleDetail(article: article))
            }
        }
    }
}



