//
//  NextHolidayWidget.swift
//  NextHolidayWidget
//
//  Created by Elvis on 20/03/26.
//

import WidgetKit
import SwiftUI

let MockHoliday = HolidayEntry(
    name: "Hari Libur Nasional",
    actualDate: Date(),
    days_until: 0,
    date: Date()
)

let NoHoliday = HolidayEntry(
    name: "Belum ada libur",
    actualDate: nil,
    days_until: nil,
    date: Date()
)

let FallbackHoliday = HolidayEntry(
    name: "⚠️ Gagal memuat",
    actualDate: nil,
    days_until: nil,
    date: Date()
)

struct NextHolidayWidget: Widget {
    let kind: String = "NextHolidayWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                NextHolidayWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                NextHolidayWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Pantau Hari Libur")
        .description("Melihat hari libur selanjutnya tanpa membuka aplikasi")
        .contentMarginsDisabled()
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> HolidayEntry {
        return MockHoliday
    }
    
    func getSnapshot(in context: Context, completion: @escaping (HolidayEntry) -> ()) {
        completion(placeholder(in: context))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let service = HolidayService()
                let holiday = try await service.getNextHoliday()
                let entry = HolidayEntry(from: holiday)
                
                let timeline = createTimeline(entry: entry)
                completion(timeline)
            } catch {
                let timeline = createTimeline(entry: FallbackHoliday)
                completion(timeline)
            }
        }
    }
    
    private func createTimeline(entry: HolidayEntry, after: Date? = nil) -> Timeline<HolidayEntry> {
        let tomorrowMidnight = Calendar.current.startOfDay(for: Date())
            .addingTimeInterval(86400)
        
        return Timeline(
            entries: [entry],
            policy: .after(after ?? tomorrowMidnight)
        )
    }
}

struct NextHolidayWidgetEntryView : View {
    var entry: Provider.Entry
    
    private var daysUntilText: String {
        guard let days_until = entry.days_until else {
            return "-"
        }
        
        if days_until == 0 {
            return "Hari Ini 🎉"
        } else {
            return "\(days_until) Hari Lagi"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack{}
                .frame(maxWidth: .infinity, minHeight: 36)
                .background(.red)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.name)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(hex: "#636363")
                        .lineLimit(1)
                    
                    if let date = entry.actualDate {
                        Text(date.formatted(.dateTime.day().month(.wide)))
                            .font(.system(size: 20, weight: .bold))
                    } else {
                        Text("-")
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                
                VStack {
                    if (entry.days_until != nil) {
                        Text(daysUntilText)
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(hex: "#F5F5F5")
                            .cornerRadius(16)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(16)
        }
        .background(.background)
    }
}

#Preview(as: .systemSmall) {
    NextHolidayWidget()
} timelineProvider: {
    Provider()
}
