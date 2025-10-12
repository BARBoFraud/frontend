//
//  FeedViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/09/24.
//

import Foundation

@MainActor
final class FeedViewModel: ObservableObject {
    
    @Published var posts: Feed = []
    @Published var isLoading = true
    @Published var errorMessage: String?

    func fetch() async throws {
        isLoading = true
        errorMessage = nil
        do {
            posts = try await NetworkManager.shared.getFeed()
        } catch {
            errorMessage = "No se pudieron cargar las incidencias. \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    func like(id postID: Int) async throws {
        do{
            let _ = try await NetworkManager.shared.like(postID: postID)
        } catch {
            errorMessage = "No se pudo likear \(error.localizedDescription)"
        }
    }
    
    func unlike(id postID: Int) async throws {
        do{
            let _ = try await NetworkManager.shared.like(postID: postID)
        } catch {
            print("No se pudo quitar el like \(error.localizedDescription)")
        }
    }
}
