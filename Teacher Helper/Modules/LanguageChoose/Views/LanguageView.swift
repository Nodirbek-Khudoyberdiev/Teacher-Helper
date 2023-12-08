//
//  LanguageView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import UIKit

protocol LanguagePickedDelegate: AnyObject {
    func didTapLanguage(_ language: Localization)
}

class LanguageView: BaseView {
    
    weak var delegate: LanguagePickedDelegate?
    
    var touchesBegin: UIColor? {
        return .Gray._300
    }
    
    var touchesEnd: UIColor? {
        return .white
    }
    
    var isSelectionEnabled: Bool = true
    
    lazy var titleLabel: BaseLabel = {
        let label = BaseLabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .Gray._700
        label.font = .inter(font: .semiBold, size: 16)
        return label
    }()
    
    private let language: Localization
    
    init(language: Localization){
        self.language = language
        super.init(frame: .zero)
        self.titleLabel.text = language.title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        backgroundColor = .white
        borderRadius = 8
        borderColor = .Gray._300
        addSubview(titleLabel)
        addTapGesture(tapNumber: 1, target: self, action: #selector(didTapSelf))
    }
    
    func setupConstrains() {
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func didTapSelf(){
        delegate?.didTapLanguage(language)
    }
    
}
