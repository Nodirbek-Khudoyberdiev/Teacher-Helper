//
//  LaunguageChooseView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit
import SnapKit

class LaunguageChooseView: BaseView {
    
    let languages: [Localization] = [.UZ, .UzCyrclic, .ENGLISH, .RUSSIAN]
    
    lazy var iconImageView = UIImageView.defualtImageView()
    lazy var appTitle: BaseLabel = {
        let label = BaseLabel()
        label.font = .inter(font: .bold, size: 32)
        label.textColor = .appPrimaryColor
        label.textAlignment = .center
        label.text = "Teacher Helper"
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.build(axis: .vertical,
                        alignment: .fill,
                        distribution: .fillEqually,
                        spacing: 16)
        return stackView
    }()
    
    let delegate: LanguagePickedDelegate?
    
    init(delegate: LanguagePickedDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        languages.forEach {
            let languageView = LanguageView(language: $0)
            languageView.delegate = delegate
            stackView.addArrangedSubview(languageView)
        }
        backgroundColor = .white
        iconImageView.image = .launchImage
        addSubviews(iconImageView, appTitle, stackView)
    }
    
    func setupConstrains() {
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        appTitle.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(appTitle.snp.bottom).offset(64)
            make.left.right.equalToSuperview().inset(16)
        }
        
    }
}
