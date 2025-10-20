//
//  History.swift
//  BARBoFraud
//
//  Created by Jorge Cadena on 15/10/25.
//

import SwiftUI

struct History: View {
    @EnvironmentObject var router: Router
    @StateObject var vm = HistoryViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ViewHeader(title: "Historial")
                Group {
                    if vm.isLoading {
                        VStack{
                            Spacer()
                            ProgressView("Cargando Post")
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                            Spacer()
                        }
                    } else if vm.results.isEmpty {
                        VStack {
                            Spacer()
                            Text("No results found")
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(vm.results) { result in
                                    Divider()
                                    // ZStack to hold the bg and information
                                    ZStack {
                                        // Rectangle bg
                                        Rectangle()
                                            .fill(.appBg)
                                            .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                                        // HStack to hold card sections
                                        HStack(spacing: 15) {
                                            // Title and Creation date
                                            VStack(alignment: .leading) {
                                                Text(result.title)
                                                    .font(.title2)
                                                Text(DateUtils.formatDate(from: result.createdAt))
                                                    .font(.footnote)
                                                    .foregroundStyle(.text.opacity(0.4))
                                            }
                                            .padding([.leading, .trailing], 10)
                                            Spacer()
                                            // Report status and category
                                            VStack(alignment: .trailing) {
                                                Text("\(result.status)")
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 4)
                                                    .background(PostUtils.getStatusLabelBackgroundColor(for: result.status))
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                               
                                                Text("\(PostUtils.getCategoryLabel(from: result.category))")
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 4)
                                                    .background(PostUtils.getLabelBackgroundColor(for: result.category))
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            }
                                            .padding([.trailing, .leading], 10)
                                        }
                                        .padding(.vertical, 10)
                                    } // ZStack
                                    .onTapGesture {
                                        router.push(.historyDetail(postId: result.id))
                                    }
                                    .fixedSize(horizontal: false, vertical: true)
                                } // ForEach
                            } // LazyView
                        } // ScrollView
                    } // if
                } // Group
                .task {
                    let _ = await vm.fetchAll()
                } // task
            } // VStack
        } // ZStack
        .background(.appBg)
        .navigationBarBackButtonHidden(true)
    } // body
} // History

#Preview {
    History()
//    RootView()
}
