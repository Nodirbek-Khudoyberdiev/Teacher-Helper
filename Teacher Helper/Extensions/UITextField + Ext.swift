//
//  UITextField + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import UIKit

extension UITextField {
    func setPlaceholder(placeholder: String, _ color: UIColor){
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
    
    func builder(font: UIFont, textAlignment: NSTextAlignment){
        self.font = font
        self.textAlignment = textAlignment
    }
}
