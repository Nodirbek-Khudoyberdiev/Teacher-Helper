//
//  RegisterView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/12/23.
//

import UIKit

class RegisterView: BaseView {

    lazy var firstField = TitledTextField(title: "Логин", txtFieldType: .email)
    lazy var secondField = TitledTextField(title: "Пароль", txtFieldType: .password)
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.build(axis: .vertical,
                        alignment: .fill,
                        distribution: .fillEqually,
                        spacing: 16,
                        views: [firstField, secondField])
        return stackView
    }()
    
    lazy var titleLabel: BaseLabel = {
        let label = BaseLabel()
        label.build(text: .localized(.register), font: .inter(font: .bold, size: 24), color: .Gray._700, lines: 1, alignment: .center)
        return label
    }()
    
    lazy var subtitleLabel: BaseLabel = {
        let stringValue = "Уже есть аккаунт? Вход"
        let label = BaseLabel()
        label.build(font: .inter(font: .regular, size: 14), color: .Gray._700, lines: 2, alignment: .center)
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        
        attributedString.setColorForText(textForAttribute: "Уже есть аккаунт?", withColor: .Gray._700)
        attributedString.setColorForText(textForAttribute: "Вход", withColor: .appPrimaryColor)
        label.attributedText = attributedString
        return label
    }()
    
    lazy var nextButton = PrimaryButton(title: .localized(.register))
    
    func setup() {
        firstField.setPlaceholder(txtFieldPlaceholder: "Почта или телефон")
        secondField.setPlaceholder(txtFieldPlaceholder: "Пароль...")
        backgroundColor = .white
        addSubviews(stackView, titleLabel, subtitleLabel, nextButton)
    }
    
    func setupConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
    }
}
