//
//  OtpView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 23/12/23.
//

import UIKit

class OtpView: BaseView {
    
    lazy var clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "clock")
        imageView.snp.makeConstraints({
            $0.size.equalTo(24)
        })
        return imageView
    }()
    
    lazy var timeLabel: BaseLabel = {
        let label = BaseLabel()
        label.build(text: "1:00", font: .inter(font: .regular, size: 20), color: .Gray._700, lines: 1, alignment: .left)
        return label
    }()
    
    lazy var timeContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.build(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 8, views: [clockImageView, timeLabel])
        return stackView
    }()
    
    
    lazy var titleLabel: BaseLabel = {
        let label = BaseLabel()
        label.build(text: .localized(.register), font: .inter(font: .bold, size: 24), color: .Gray._700, lines: 1, alignment: .center)
        return label
    }()
    
    lazy var subtitleLabel: BaseLabel = {
        let label = BaseLabel()
        label.build(font: .inter(font: .medium, size: 16), color: .Gray._700, lines: 1, alignment: .center)
        return label
    }()
    
    lazy var attemtLabel: BaseLabel = {
        let label = BaseLabel()
        label.build(text: "Осталось 2 попытки",
                    font: .inter(font: .regular, size: 14),
                    color: .Gray._600,
                    lines: 1,
                    alignment: .left)
        return label
    }()
    
    lazy var getCodeLabel: BaseLabel = {
        let label = BaseLabel()
        label.build(text: "Получить новый код",
                    font: .inter(font: .semiBold, size: 14),
                    color: .appPrimaryColor,
                    lines: 1,
                    alignment: .left)
        return label
    }()
    
    lazy var retryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "refresh")
        imageView.snp.makeConstraints { make in
            make.size.equalTo(20)
        }
        return imageView
    }()
    
    lazy var retryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.build(axis: .horizontal,
            alignment: .fill,
            distribution: .fill,
            spacing: 8,
            views:
                [
                    attemtLabel, retryImageView, getCodeLabel
                ]
        )
        return stackView
    }()
    
    lazy var otpContainerView = OtpContainerView()
    
    lazy var nextButton: PrimaryButton = {
        let button = PrimaryButton(title: "Далее")
        return button
    }()
    
    func setup() {
        addSubviews(titleLabel, subtitleLabel, otpContainerView, retryStackView, nextButton, timeContainerStackView)
    }
    
    func setupConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        otpContainerView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.height.equalTo(42)
            make.centerX.equalToSuperview()
        }
        
        retryStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(otpContainerView.snp.bottom).offset(32)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(retryStackView.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        timeContainerStackView.snp.makeConstraints { make in
            make.top.equalTo(otpContainerView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
    }
}
