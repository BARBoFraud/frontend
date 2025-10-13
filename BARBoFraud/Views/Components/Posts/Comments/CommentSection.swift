//
//  CommentSection.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/11.
//

import SwiftUI

struct CommentSection: View {
    @StateObject var vm = CommentsViewModel()
    
    var id : Int = 0
    
    var body: some View {
        Group{
            if vm.isLoading {
                VStack{
                    Spacer()
                    ProgressView("Cargando")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    Spacer()
                }
            }else if let error = vm.errorMessage{
                VStack{
                    Spacer()
                    Text(error).padding()
                    Spacer()
                }
            }else if vm.comments.isEmpty{
                VStack{
                    Spacer()
                    Text("Aún no hay comentarios")
                    Spacer()
                }
            }else{
                ForEach(0..<vm.comments.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        CommentView(comment: vm.comments[index])
                            .padding([.leading, .trailing])
                    }
                }
            }
        }.task{
            do{
                try await vm.getComments(id: id)
            } catch {
                print(error)
            }
            
        }
    }
}

#Preview {
    CommentSection(id: 5)
}
