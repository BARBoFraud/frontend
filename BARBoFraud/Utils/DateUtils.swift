//
//  DateUtils.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/12.
//

import Foundation

struct DateUtils{

    static func formatDate(from dateString: String, includeTime: Bool = false) -> String{

        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = isoFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium   // or .short, .long, .full
            dateFormatter.timeStyle = includeTime ? .short : .none    // or .none, .long
            dateFormatter.locale = Locale.autoupdatingCurrent //Locale(identifier: "es_MX")  // Ensures formatting is localized
            return dateFormatter.string(from: date)
        }
        return "bad date"
    }
}
