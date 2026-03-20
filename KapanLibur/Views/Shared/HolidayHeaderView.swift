//
//  HolidayHeaderView.swift
//  KapanLibur
//
//

import SwiftUI

struct HolidayHeaderView: View {
    let holiday: Holiday
    let date: Date
    
    func formatDate(_ date: Date) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "id_ID")
        outputFormatter.dateFormat = "EEEE, d MMMM yyyy"
        return outputFormatter.string(from: date)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Text(holiday.is_joint ? "Cuti Bersama" : "Hari Libur")
                .font(.libreBaskerville(size: 18))
                .foregroundColor(hex: "#636363")
            
            Divider().padding(.horizontal, 56)
            
            VStack(spacing: 16) {
                Text(holiday.name)
                    .font(.libreBaskerville(size: 32, weight: .bold))
                    .foregroundColor(hex: "#3F3F3F")
                    .multilineTextAlignment(.center)
                
                Text(formatDate(date))
                    .font(.libreBaskerville(size: 14))
                    .foregroundColor(hex: "#718096")
            }
        }
    }
}

#Preview {
    HolidayHeaderView(
        holiday: Holiday(
            name: "Idul Fitri 1447 H",
            date: "2026-03-20",
            day: "Jumat",
            days_until: 0,
            is_joint: false,
            is_today: true
        ),
        date: Date()
    )
}
