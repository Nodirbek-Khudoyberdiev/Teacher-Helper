//
//  UIButton + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import UIKit

extension UIButton {
    static func highLightedButton(title: String, textColor: UIColor, size: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = .inter(font: .regular, size: size)
        return button
    }
}
