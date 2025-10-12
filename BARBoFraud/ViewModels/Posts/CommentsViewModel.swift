//
//  CommentsViewModel.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/10.
//

import Foundation

@MainActor
final class CommentsViewModel: ObservableObject {
    
    @Published var comments: Comments = []
    @Published var isLoading = true
    @Published var errorMessage: String?

    func comment(id reportID: Int, text: String) async {
        do{
            let _ = try await NetworkManager.shared.comment(id: reportID, text: text)
        } catch {
            print("No se pudo comentar el reporte \(error.localizedDescription)")
        }
    }
    
    func getComments(id reportID: Int) async throws {
        isLoading = true
        do{
             comments = try await NetworkManager.shared.getComments(id: reportID)
        } catch {
            print("No se pudieron obtener los comentarios \(reportID) + \(error.localizedDescription)")
            throw error
        }
        isLoading = false
    }
}
