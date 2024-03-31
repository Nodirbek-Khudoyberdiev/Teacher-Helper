//
//  MainView.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/02/24.
//

import UIKit

class MainView: UIScrollView {
    
    lazy var contentStackView: UIStackView = {
        let margin: CGFloat = 16
        let margins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        let stackView = UIStackView(axis: .vertical,
                                    distribution: .fill,
                                    alignment: .fill,
                                    layoutMargins: margins,
                                    spacing: 24)
        return stackView
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
        setupConstrains()
    }
}

private extension MainView {
    func setup() {
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        addSubview(contentStackView)
    }
    
    func setupConstrains() {
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(superview ?? self)
        }
    }
}
