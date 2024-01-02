//
//  RegisterView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/12/23.
//

import UIKit

class RegisterView: BaseView {

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
                            nextButton
                        ])
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
        stackView.setCustomSpacing(32, after: secondField)
        
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
