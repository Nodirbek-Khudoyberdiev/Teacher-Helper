//
//  UIColor + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static let appPrimaryColor = UIColor(hex: "58D5D3")
    static let appBlackColor = UIColor(hex: "101828")
    
    struct Blue {
        static let _400 = UIColor(hex: "40BFC1")
        static let _2E85FF = UIColor(hex: "2E85FF")
    }
    
    struct Gray {
        static let _300 = UIColor(hex: "D0D5DD")
        static let _700 = UIColor(hex: "344054")
        static let _500 = UIColor(hex: "667085")
        static let _200 = UIColor(hex: "EAECF0")
        static let _600 = UIColor(hex: "475467")
    }
    
    
    

}


