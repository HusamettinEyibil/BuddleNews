//
//  DateExtension.swift
//  BuddleNews
//
//  Created by Hüsamettin Eyibil on 13.03.2022.
//

import Foundation

extension Date {
    public static func utcToLocal(dateStr: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = formatter.date(from: dateStr) {
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
        return nil
    }
}
