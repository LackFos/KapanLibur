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
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.date(from: dateString)
}
