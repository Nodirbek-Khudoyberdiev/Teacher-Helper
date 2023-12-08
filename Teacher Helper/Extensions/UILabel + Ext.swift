//
//  UILabel + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import UIKit

extension UILabel {
    func build(text: String? = nil, font: UIFont, color: UIColor, lines: Int, alignment: NSTextAlignment = .left){
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = lines
        self.textAlignment = alignment
    }
}
