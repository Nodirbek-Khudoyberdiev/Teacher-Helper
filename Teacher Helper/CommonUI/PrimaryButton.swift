//
//  PrimaryButton.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import UIKit

class PrimaryButton: UIButton, ActivityIndicatorProtocol {
    
    lazy var activictyIndicator = ActivityIndicator()
    
    init(title: String){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .inter(font: .semiBold, size: 16)
        backgroundColor = .Main._400
        cornerRadius = 8
        setupConstraints()
        setBackgroundColor(color: .Main._400, forState: .normal)
        setBackgroundColor(color: .Main._500, forState: .highlighted)
        setBackgroundColor(color: .Main._200, forState: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints(){
        addSubview(activictyIndicator)
        snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        activictyIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimating(_ value: Bool){
        isEnabled = !value
        if value {
            activictyIndicator.startAnimating()
            titleLabel?.alpha = 0
        } else {
            activictyIndicator.stopAnimating()
            titleLabel?.alpha = 1
        }
    }
    
    
}
