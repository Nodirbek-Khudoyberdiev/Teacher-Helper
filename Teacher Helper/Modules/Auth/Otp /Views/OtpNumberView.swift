//
//  OtpNumberView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 23/12/23.
//

import UIKit

class OtpNumberView: BaseView {
    
    lazy var label: BaseLabel = {
        let label = BaseLabel()
        label.build(text: "0", font: .inter(font: .medium, size: 28), color: .Gray._200, lines: 1, alignment: .center)
        return label
    }()
    
    func setup() {
        borderColor = .Gray._300
        borderWidth = 1
        borderRadius = 8
        addSubview(label)
    }
    
    func setupConstrains() {
        
        snp.makeConstraints { make in
            make.height.equalTo(42)
            make.width.equalTo(47.33)
        }
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
