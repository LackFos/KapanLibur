//
//  HolidayEntry.swift
//  KapanLibur
//
//  Created by Elvis on 30/03/26.
//

import WidgetKit

struct HolidayEntry: TimelineEntry {
    let name: String
    let actualDate: Date?
    let days_until: Int?
    let date: Date
    
    init(name: String, actualDate: Date?, days_until: Int?, date: Date) {
        self.name = name
        self.actualDate = actualDate
        self.days_until = days_until
        self.date = date
    }
}

extension HolidayEntry {
    init(from holiday: Holiday) {
        let parsedDate = DateParser(holiday.date)

        self.name = holiday.name
        self.actualDate = parsedDate
        self.days_until = holiday.days_until
        self.date = Date()
    }
}
