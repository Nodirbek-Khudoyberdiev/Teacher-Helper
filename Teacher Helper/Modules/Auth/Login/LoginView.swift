//
//  LoginView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit

class LoginView: BaseView {
    
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
        label.build(text: "Вход", font: .inter(font: .bold, size: 24), color: .Gray._700, lines: 1, alignment: .center)
        return label
    }()
    
    lazy var subtitleLabel: BaseLabel = {
        let stringValue = "У вас еще нет аккаунта? Регистрация"
        let label = BaseLabel()
        label.build(font: .inter(font: .regular, size: 14), color: .Gray._700, lines: 2, alignment: .center)
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        
        attributedString.setColorForText(textForAttribute: "У вас еще нет аккаунта?", withColor: .Gray._700)
        attributedString.setColorForText(textForAttribute: "Регистрация", withColor: .appPrimaryColor)
        label.attributedText = attributedString
        return label
    }()
    
    lazy var forgotPassword: UIButton = {
        let button = UIButton()
        let stringValue = "Забыли пароль?"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColorForText(textForAttribute: stringValue, withColor: .Blue._2E85FF, underline: true)
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.font = .inter(font: .regular, size: 14)
        return button
    }()
    
    lazy var nextButton = PrimaryButton(title: "Войти")
    
    func setup() {
        firstField.setPlaceholder(txtFieldPlaceholder: "Почта или телефон")
        secondField.setPlaceholder(txtFieldPlaceholder: "Пароль...")
        backgroundColor = .white
        addSubviews(stackView, titleLabel, subtitleLabel, nextButton, forgotPassword)
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
        
        forgotPassword.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(6)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPassword.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
    }
}
