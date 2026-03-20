//
//  ContentView.swift
//  KapanLibur
//
//  Created by Elvis on 19/03/26.
//

import SwiftUI

struct ContentView: View {
    @State private var nextHoliday: Holiday?
    
    var body: some View {
        ZStack {
            topLogoLayer
            centerContentLayer
            bottomSwipeLayer
        }
        .padding(.horizontal, 24)
        .task { await loadHoliday() }
    }
    
    // MARK: - Layers
    private var topLogoLayer: some View {
        VStack {
            AppLogoView().padding(.top, 8)
            Spacer()
        }
    }
    
    private var centerContentLayer: some View {
        VStack(spacing: 48) {
            if let holiday = nextHoliday,
               let targetDate = DateParser(holiday.date) {
                HolidayHeaderView(holiday: holiday, date: targetDate)
                CountDownView(date: targetDate)
            } else {
                ProgressView()
            }
        }
    }
    
    private var bottomSwipeLayer: some View {
        VStack {
            Spacer()
            SwipeForMoreView()
        }
    }
    
    // MARK: - Helpers
    private func loadHoliday() async {
        let service = HolidayService()
        nextHoliday = try? await service.getNextHoliday()
    }
}

#Preview {
    ContentView()
}
