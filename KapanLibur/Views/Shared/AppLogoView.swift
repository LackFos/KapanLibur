//
//  AppLogo.swift
//  KapanLibur
//
//  Created by Elvis on 20/03/26.
//

import SwiftUI

struct AppLogoView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Kapan")
            Text("Libur").foregroundColor(.red)
        }
        .font(.jetbrainsMono(size: 18, weight: .bold))
    }
}

#Preview {
    AppLogoView()
}
