//
//  parseDate.swift
//  KapanLibur
//
//  Created by Elvis on 20/03/26.
//

import Foundation

func DateParser(_ dateString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone.current
    return formatter.date(from: dateString)
}
