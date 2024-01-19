//
//  ChangePasswordView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/01/24.
//

import UIKit

class ChangePasswordView: BaseView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.build(text: "Новый пароль",
                    font: .inter(font: .bold, size: 24),
                    color: .Gray._700,
                    lines: 1,
                    alignment: .center)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.build(text: "Пароль должен состоять минимум из 7 букв и 1 цифры",
                    font: .inter(font: .regular, size: 14),
                    color: .Gray._700,
                    lines: 0,
                    alignment: .center)
        return label
    }()
    
    lazy var passwordTextField: TitledTextField = {
        let textField = TitledTextField(title: "Пароль", txtFieldType: .password)
        textField.setPlaceholder(txtFieldPlaceholder: "Введите пароль...")
        return textField
    }()
    
    lazy var mainButton: PrimaryButton = {
        let button = PrimaryButton(title: "Сбросить пароль")
        return button
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.build(axis: .vertical,
                        alignment: .fill,
                        distribution: .fill,
                        spacing: 0,
                        views: [
                            titleLabel, subtitleLabel, passwordTextField, mainButton
                        ])
        return stackView
    }()
    
    func setup() {
        contentStackView.setCustomSpacing(16, after: titleLabel)
        contentStackView.setCustomSpacing(32, after: subtitleLabel)
        contentStackView.setCustomSpacing(32, after: passwordTextField)
        addSubview(contentStackView)
    }
    
    func setupConstrains() {
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
