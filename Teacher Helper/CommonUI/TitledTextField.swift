//
//  TitledTextField.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import UIKit

class TitledTextField: UIStackView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        let font: UIFont = .inter(font: .medium, size: 14)
        label.build(font: font, color: .Gray._700, lines: 1)
        return label
    }()
    
    lazy var textField: TextField = {
        let padding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 36)
        let textField = TextField(type: type, padding: padding)
        textField.cornerRadius = 8
        textField.borderColor = .Gray._300
        textField.autocorrectionType = .no
        textField.textColor = .black
        textField.font = .inter(font: .regular, size: 16)
        textField.tintColor = .black
        return textField
    }()
    
    let type: TextFieldInputType
    
    init(title: String, txtFieldType: TextFieldInputType){
        self.type = txtFieldType
        super.init(frame: .zero)
        titleLabel.text = title
        build(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 6, views: [titleLabel, textField])
        textField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func setPlaceholder(txtFieldPlaceholder: String){
        textField.setPlaceholder(placeholder: txtFieldPlaceholder, .Gray._500)
    }

    
    
}
