//
//  ForgotPasswordView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 02/01/24.
//

import UIKit

class ForgotPasswordView: BaseView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.build(text: "Забыли пароль",
                    font: .inter(font: .bold, size: 24), 
                    color: .Gray._700,
                    lines: 1,
                    alignment: .center)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.build(text: "Введите телефон и мы отправим код для восстановления",
                    font: .inter(font: .regular, size: 14),
                    color: .Gray._700,
                    lines: 0,
                    alignment: .center)
        return label
    }()
    
    lazy var phoneTextField: TitledTextField = {
        let textField = TitledTextField(title: "Логин", txtFieldType: .phone)
        textField.setPlaceholder(txtFieldPlaceholder: "Номер телефона")
        return textField
    }()
    
    lazy var mainButton: PrimaryButton = {
        let button = PrimaryButton(title: "Отправить код")
        return button
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.build(axis: .vertical,
                        alignment: .fill,
                        distribution: .fill,
                        spacing: 0, 
                        views: [
                            titleLabel, subtitleLabel, phoneTextField, mainButton
                        ])
        return stackView
    }()
    
    func setup() {
        contentStackView.setCustomSpacing(16, after: titleLabel)
        contentStackView.setCustomSpacing(32, after: subtitleLabel)
        contentStackView.setCustomSpacing(32, after: phoneTextField)
        addSubview(contentStackView)
    }
    
    func setupConstrains() {
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}

