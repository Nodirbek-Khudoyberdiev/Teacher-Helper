//
//  PasswordChangedView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/01/24.
//

import UIKit

class PasswordChangedView: BaseView {
    
    lazy var imageView: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        let imageView = UIImageView(frame: frame)
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
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.build(axis: .vertical,
                        alignment: .fill,
                        distribution: .fill,
                        spacing: 0,
                        views: [
                            imageView, passwordChangedLabel, loginButton
                        ])
        return stackView
    }()
    
    func setup() {
        stackView.setCustomSpacing(12, after: imageView)
        stackView.setCustomSpacing(52, after: passwordChangedLabel)
        addSubview(stackView)
    }
    
    func setupConstrains() {
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
}
