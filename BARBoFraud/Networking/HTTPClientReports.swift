//
//  HTTPClientReports.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 06/10/25.
//

import Foundation

enum postReportError: Error {
    case categoryDoesNotExist
    case invalidJWT
    case serverError(statusCode: Int)
}

struct HTTPClientReports {
    func PublishReport(categoryID: Int, description: String, url: String?, website: String?, socialMedia: String?, phoneNumber: String?, userName: String?, email: String?, anonymous: Bool, imageId: String) async throws {
        let requestForm = ReportRequest(categoryID: categoryID, description:description, url:url, website: website, socialMedia: socialMedia, phoneNumber: phoneNumber, username: userName, email: email, anonymous: anonymous, imageId: imageId)
        guard let url = URL(string: "http://localhost:4000/v1/reports/create") else {
            fatalError("Invalid URL" + "http://localhost:4000/v1/reports/create")
        }
        
        var httpRequest = URLRequest(url: url)
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsInR5cGUiOiJhY2Nlc3MiLCJhY3RvciI6InVzZXIiLCJpYXQiOjE3NjAwMzM4NzksImV4cCI6MTc2MDAzNzQ3OX0.o1DlEy7UGw9GTAYb4J3InUttmpbbWJXv3fGPdORAOoY"
        
        httpRequest.httpMethod = "POST"
        httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = try JSONEncoder().encode(requestForm)
        httpRequest.httpBody = jsonData
        
        let(_, response) = try await URLSession.shared.data(for: httpRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
        
        switch httpResponse.statusCode {
                    case 201:
                        print("Reporte enviado con exito")
                        return
                    case 404:
                        throw postReportError.categoryDoesNotExist
                    case 401:
                        throw postReportError.invalidJWT
                    default:
                        throw postReportError.serverError(statusCode: httpResponse.statusCode)
                    }
    }
}
