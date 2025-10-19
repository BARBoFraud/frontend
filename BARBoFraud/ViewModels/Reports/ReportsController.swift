//
//  ReportsController.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 06/10/25.
//

import Foundation
import UIKit

@MainActor
final class ReportsController: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var categories: [IDCategoryRequest] = []
    private var fileKey: String = ""
    
    func uploadImage(_ image: UIImage) async {
        do{
            fileKey = try await NetworkManager.shared.uploadImage(image)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func newReport(categoryID: Int, title: String, description: String, url: String?, website: String?, application: String?, phoneNumber: String?, userName: String?, email: String?, anonymous: Bool) async {
        isLoading = true
        
        
        do{
            let _ = try await NetworkManager.shared.publishReport(categoryID: categoryID, title: title, description: description, url: url, website: website, application: application, phoneNumber: phoneNumber, userName: userName, email: email, anonymous: false, imageId: fileKey)
        }catch {
            errorMessage = "No se pudo publicar el reporte. Inténtelo más tarde \(error)"
        }
        
        isLoading = false
    }
    
    func getCategories() async {
        isLoading = true
        do{
            categories = try await NetworkManager.shared.getCategoryID()
            
        }catch {
            errorMessage = "No se pudo obtener la categoria \(error.localizedDescription)"
        }
        isLoading = false
    }
}
