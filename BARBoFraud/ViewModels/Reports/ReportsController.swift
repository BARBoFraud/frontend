//
//  ReportsController.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 06/10/25.
//

import Foundation

struct ReportsController {
    let httpClient: HTTPClientReports
    func publishAReport(description: String, url: String?, website: String?, socialMedia: String?, phoneNumber: String?, userName: String?, email: String?, anonymous: Bool, imageId: String) async throws {
        try await httpClient.PublishReport(description:description, url:url, website: website, socialMedia: socialMedia, phoneNumber: phoneNumber, userName: userName, email: email, anonymous: anonymous, imageId: imageId)
    }
    
    
}
