//
//  View+Extension.swift
//  KapanLibur
//
//  Created by Elvis on 20/03/26.
//

import SwiftUI

extension View {
    func foregroundColor(hex: String) -> some View {
        self.foregroundColor(Color(hex: hex))
    }

    func background(hex: String) -> some View {
        self.background(Color(hex: hex))
    }
}
