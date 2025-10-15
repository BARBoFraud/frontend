//
//  PostViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/10.
//

import Foundation
import SwiftUI

@MainActor
final class PostViewModel: ObservableObject {
    
    var postID : Int = 0
    
    @Published var post: Post = Post(name: nil, lastName: nil, image: nil, url: "", website: "", socialMedia: "", username: "", email: "", phoneNumber: "", id: 1, category: "", date: "", riskLevel: "'", title: "", description: "", likeCount: 0, commentCount: 0, userLiked: 0)
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var image: Image?

    func getPost(id postID: Int) async throws {
        isLoading = true
        errorMessage = nil
        do {
            post = try await NetworkManager.shared.getPost(id: postID)
            if (post.image != nil){
                await loadImage(from: post.image!)
            }
        } catch {
            errorMessage = "No se pudo cargar el post. \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func loadImage(from imageKey: String) async {
        if let url = URL(string: imageKey){
            image = await ImageLoader().load(from: url)
        }else{
            print("URL inválida")
        }
    }
}
