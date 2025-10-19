//
//  ReportsClient.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 11/10/25.
//
import Foundation
import UIKit


extension NetworkManager {
    func publishReport(categoryID: Int, title: String, description: String, url: String?, website: String?, application: String?, phoneNumber: String?, userName: String?, email: String?, anonymous: Bool, imageId: String) async throws -> EmptyResponse {
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
                    throw NetworkError.noToken
                }
        let body = ReportRequest(categoryId: categoryID, title: title, description: description, url: url, website: website, application: application, phoneNumber: phoneNumber, username: userName, email: email, anonymous: false, imageId: imageId)
        
        return try await request("/reports/create", method:"POST", token:token, body: body)
    }
    
    func uploadImage(_ image: UIImage) async throws -> String{
        guard let url = URL(string:"\(AppConfig.apiBaseUrl)/images/upload"),
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        guard let token = TokenStorage.get(identifier: "accessToken"), !token.isEmpty else {
                    throw NetworkError.noToken
                }
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        // Límite del multipart
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // Construcción del body
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"foto.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        let (data, response) = try await URLSession.shared.upload(for: request, from: body)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                throw URLError(.badServerResponse)
            }
        let decoded = try JSONDecoder().decode(UpLoadImageDTO.self, from: data)
            return decoded.fileKey
        
    }
    
    func getCategoryID() async throws -> [IDCategoryRequest] {
        return try await request("/categories/list", body: Optional<Data>.none)
    }
}
