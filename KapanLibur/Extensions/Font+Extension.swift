//
//  Font+Extension.swift
//  KapanLibur
//
//  Created by Elvis on 20/03/26.
//

import SwiftUI

extension Font {
    // MARK: - Libre Baskerville (Static Font)
    static func libreBaskerville(size: CGFloat, weight: LibreBaskervilleWeight = .regular) -> Font {
        .custom("LibreBaskerville-Regular", size: size).weight(weight.fontWeight)
    }
    
    enum LibreBaskervilleWeight {
        case thin
        case light
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        
        var fontWeight: Font.Weight {
            switch self {
            case .thin: return .thin
            case .light: return .light
            case .regular: return .regular
            case .medium: return .medium
            case .semiBold: return .semibold
            case .bold: return .bold
            case .extraBold: return .heavy
            }
        }
    }
    
    // MARK: - JetBrains Mono (Variable Font)
    static func jetbrainsMono(size: CGFloat, weight: JetBrainsMonoWeight = .regular) -> Font {
        .custom("JetBrainsMono-Regular", size: size).weight(weight.fontWeight)
    }
    
    enum JetBrainsMonoWeight {
        case thin
        case light
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        
        var fontWeight: Font.Weight {
            switch self {
            case .thin: return .thin
            case .light: return .light
            case .regular: return .regular
            case .medium: return .medium
            case .semiBold: return .semibold
            case .bold: return .bold
            case .extraBold: return .heavy
            }
        }
    }
}
