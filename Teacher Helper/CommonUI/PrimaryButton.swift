//
//  PrimaryButton.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import UIKit

class PrimaryButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = .Blue._400.withAlphaComponent(isEnabled ? 1 : 0.5)
        }
    }
    
    init(title: String){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .inter(font: .semiBold, size: 16)
        backgroundColor = .Blue._400
        cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
