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
}
