//
//  PasswordChangedView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/01/24.
//

import UIKit

class PasswordChangedView: BaseView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "changedIcon")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var passwordChangedLabel: UILabel = {
        let label = UILabel()
        label.build(text: "Пароль успешно изменен",
                    font: .inter(font: .semiBold, size: 18),
                    color: .Gray._900,
                    lines: 1,
                    alignment: .center)
        return label
    }()
    
    lazy var loginButton = PrimaryButton(title: "Войти")
    
    func setup() {
        addSubviews(imageView, passwordChangedLabel, loginButton)
    }
    
    func setupConstrains() {
        
        imageView.snp.makeConstraints({
            $0.size.equalTo(48)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        })
        
        passwordChangedLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        loginButton.snp.makeConstraints({
            $0.top.equalTo(passwordChangedLabel.snp.bottom).offset(52)
            $0.left.right.equalToSuperview().inset(16)
        })
        
    }
}
