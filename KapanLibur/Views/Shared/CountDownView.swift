//
//  CountDownView.swift
//  KapanLibur
//
//  Created by Elvis on 19/03/26.
//

import SwiftUI
import Combine

// MARK: - Components
class TimeComponent {
    func extract(from secondRemains: TimeInterval) -> String {
        fatalError("TimeComponent must implement extract(from:)")
    }
}

class DayComponent: TimeComponent {
    override func extract(from secondRemains: TimeInterval) -> String {
        String(format: "%02d", Int(secondRemains) / 86400)
    }
}

class HourComponent: TimeComponent {
    override func extract(from secondRemains: TimeInterval) -> String {
        String(format: "%02d", (Int(secondRemains) % 86400) / 3600)
    }
}

class MinuteComponent: TimeComponent {
    override func extract(from secondRemains: TimeInterval) -> String {
        String(format: "%02d", (Int(secondRemains) % 3600) / 60)
    }
}

class SecondComponent: TimeComponent {
    override func extract(from secondRemains: TimeInterval) -> String {
        String(format: "%02d", Int(secondRemains) % 60)
    }
}

// MARK: - Models
class CountDown: ObservableObject {
    @Published var secondRemains: TimeInterval
    
    private var date: Date
    private var timer: Timer?
    
    init(date: Date) {
        self.date = date
        self.secondRemains = date.timeIntervalSinceNow
    }
    
    func component(_ unit: TimeComponent) -> String {
        unit.extract(from: secondRemains)
    }
    
    func start() {
        stop()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let newSecondRemains = self.date.timeIntervalSince(Date())
            self.secondRemains = max(0, newSecondRemains)
            
            if self.secondRemains <= 0 {
                self.secondRemains = 0
                self.stop()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Views
struct CountDownView: View {
    @StateObject private var countDown: CountDown
    
    init(date: Date) {
        _countDown = StateObject(wrappedValue: CountDown(date: date))
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            CountDownUnit(value: countDown.component(DayComponent()), unitLabel: "Hari")
            CountDownUnit(value: countDown.component(HourComponent()), unitLabel: "Jam")
            CountDownUnit(value: countDown.component(MinuteComponent()), unitLabel: "Menit")
            CountDownUnit(value: countDown.component(SecondComponent()), unitLabel: "Detik")
        }
        .onAppear { countDown.start() }
        .onDisappear { countDown.stop() }
    }
}

struct CountDownUnit: View {
    let value: String
    let unitLabel: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(value)
                .font(.jetbrainsMono(size: 22))
                .fontWeight(.bold)
                .monospacedDigit()
            
            Text(unitLabel)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(hex: "#99A1B0")
        }
        .frame(width: 48, height: 48)
        .padding()
        .background(hex: "#F4F4F4")
        .cornerRadius(16)
    }
}

#Preview {
    CountDownView(date: Date().addingTimeInterval(3600))
}
