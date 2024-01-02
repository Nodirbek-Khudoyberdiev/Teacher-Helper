//
//  LoginView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit

class LoginView: BaseView {
    
    lazy var firstField = TitledTextField(title: "Логин", txtFieldType: .phone)
    lazy var secondField = TitledTextField(title: "Пароль", txtFieldType: .password)
    
    lazy var vScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.build(axis: .vertical,
                        alignment: .fill,
                        distribution: .fill,
                        spacing: 0,
                        views: [
                            titleLabel,
                            subtitleLabel,
                            firstField,
                            secondField,
                            forgotPassword,
                            nextButton
                        ])
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
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy var nextButton = PrimaryButton(title: "Войти")
    
    func setup() {
        firstField.setPlaceholder(txtFieldPlaceholder: "Номер телефона")
        secondField.setPlaceholder(txtFieldPlaceholder: "Пароль...")
        backgroundColor = .white
        addSubview(vScrollView)
        vScrollView.addSubview(stackView)
    }
    
    func setupConstrains() {
        
        stackView.setCustomSpacing(16, after: titleLabel)
        stackView.setCustomSpacing(32, after: subtitleLabel)
        stackView.setCustomSpacing(16, after: firstField)
        stackView.setCustomSpacing(6, after: secondField)
        stackView.setCustomSpacing(32, after: forgotPassword)
        
        vScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(vScrollView)
            make.left.right.equalTo(self).inset(16)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
