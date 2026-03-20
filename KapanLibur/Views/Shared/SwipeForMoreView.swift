//
//  SwipeForMoreView.swift
//  KapanLibur
//
//  Created by Elvis on 20/03/26.
//

import SwiftUI

struct SwipeForMoreView: View {
    @State var isMovingUp = false

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "chevron.up")
            Text("Lihat Semua")
        }
        .font(.jetbrainsMono(size: 12, weight: .bold))
        .opacity(isMovingUp ? 0.2 : 1.0)
        .offset(y: isMovingUp ? -10 : 0)
        .animation(
            .spring(response: 2, dampingFraction: 0.8)
            .repeatForever(autoreverses: true),
            value: isMovingUp
        )
        .onAppear {
            isMovingUp = true
        }
    }
}

#Preview {
    SwipeForMoreView()
}
