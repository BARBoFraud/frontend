//
//  DateUtils.swift
//  BARBoFraud
//
//  Created by Diego Herrera on 2025/10/12.
//

import Foundation

struct DateUtils{
    
    enum timeFrame: Int{
        case year = 0
        case month = 1
        case day = 2
    }

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
    
    static func getDateTitle(first: BarChartDataPoint, last: BarChartDataPoint) -> String{
        let firstMonth = getFrom(date: first.date, .month)
        let lastMonth = getFrom(date: last.date, .month)
        if firstMonth == lastMonth{
            return monthName(from: firstMonth)
        }else{
            return "\(monthName(from: firstMonth)) - \(monthName(from: lastMonth))"
        }
    }
    
    static func getFrom(date: String, _ unit: timeFrame) -> String{
        let parts = date.split(separator: "-")
        return String(parts[unit.rawValue])
    }
    
    static func monthName(from monthNumber: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        
        if let date = formatter.date(from: monthNumber) {
            formatter.dateFormat = "LLLL"
            return formatter.string(from: date)
        }
        return "Invalid"
    }
    
}
