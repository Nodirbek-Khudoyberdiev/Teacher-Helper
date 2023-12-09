//
//  TextField.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import UIKit

enum TextFieldInputType {
    case ordinary
    case password
    case email
}

class TextField: UITextField {
    // for textField
    private lazy var eye: UIImage? = .eyeImage
    private lazy var eyeSlash: UIImage? = .eyeSlashImage
    
    private lazy var secureButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        return button
    }()

    let padding: UIEdgeInsets
    
    override var isSecureTextEntry: Bool {
        didSet {
            let image = isSecureTextEntry ? eye : eyeSlash
            secureButton.setImage(image, for: .normal)
        }
    }
    
    init(type: TextFieldInputType = .ordinary, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)) {
        self.padding = padding
        super.init(frame: .zero)
        typeSettled(type)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        secureButton.frame = CGRect(x: CGFloat(frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func typeSettled(_ type: TextFieldInputType){
        
        switch type {
        case .password:
            rightView = secureButton
            isSecureTextEntry = true
            rightViewMode = .always
            secureButton.addTarget(self, action: #selector(toggleSecure), for: .touchUpInside)
        case .email:
            // Setup for email validation
            keyboardType = .emailAddress
            autocorrectionType = .no
            autocapitalizationType = .none
            isSecureTextEntry = false
        default:
            break
        }
    }
    
    @objc private func toggleSecure(){
        isSecureTextEntry.toggle()
    }
}

