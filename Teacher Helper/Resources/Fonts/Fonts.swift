//
//  Fonts.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit

enum InterFonts: String {
    case extraLight = "Inter-ExtraLight"
    case semiBold = "Inter-SemiBold"
    case light = "Inter-Light"
    case medium = "Inter-Medium"
    case extraBold = "Inter-ExtraBold"
    case regular = "Inter-Regular"
    case bold = "Inter-Bold"
    case black = "Inter-Black"
    case thin = "Inter-Thin"
}

extension UIFont {
    static func inter(font: InterFonts, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size)!
    }
    
}


