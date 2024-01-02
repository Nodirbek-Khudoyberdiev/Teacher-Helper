//
//  OtpContainerView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 23/12/23.
//

import UIKit

class OtpContainerView: UIStackView {
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .clear
        textField.textColor = .clear
        textField.backgroundColor = .clear
        textField.keyboardType = .numberPad
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    lazy var firstNumber = OtpNumberView()
    lazy var secondNumber = OtpNumberView()
    lazy var thirdumber = OtpNumberView()
    
    lazy var separator: UILabel = {
        let label = UILabel()
        label.build(text: "-",
                    font: .inter(font: .medium, size: 16),
                    color: .Gray._300, 
                    lines: 1,
                    alignment: .center)
        return label
    }()
    
    lazy var fourthNumber = OtpNumberView()
    lazy var fifthNumber = OtpNumberView()
    lazy var sixthNumber = OtpNumberView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        build(axis: .horizontal,
              alignment: .fill,
              distribution: .fill,
              spacing: 6,
              views: 
                [
               firstNumber,
               secondNumber, 
               thirdumber,
               separator,
               fourthNumber,
               fifthNumber,
               sixthNumber
                ]
        )
        
        separator.snp.makeConstraints { make in
            make.width.equalTo(8)
            make.height.equalTo(2)
        }
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
