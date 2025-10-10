//
//  ReportDTO.swift
//  BARBoFraud
//
//  Created by Daniel Esteban Hernández García on 06/10/25.
//

import Foundation

struct ReportRequest: Codable {
    var categoryID: Int
    var description: String
    var url: String? = nil
    var website: String? = nil
    var socialMedia: String? = nil
    var phoneNumber: String? = nil
    var username: String? = nil
    var email: String? = nil
    var anonymous: Bool
    var imageId: String
}
