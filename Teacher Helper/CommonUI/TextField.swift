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
    case phone
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
    let type: TextFieldInputType
    
    override var isSecureTextEntry: Bool {
        didSet {
            let image = isSecureTextEntry ? eye : eyeSlash
            secureButton.setImage(image, for: .normal)
        }
    }
    
    init(type: TextFieldInputType = .ordinary, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)) {
        self.padding = padding
        self.type = type
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
        delegate = self
        switch type {
        case .password:
            rightView = secureButton
            isSecureTextEntry = true
            rightViewMode = .always
            secureButton.addTarget(self, action: #selector(toggleSecure), for: .touchUpInside)
        case .phone:
            // Setup for email validation
            keyboardType = .phonePad
            autocorrectionType = .no
            autocapitalizationType = .none
            addTarget(self, action: #selector(reformatAsCardNumberOrPhoneNumber), for: .editingChanged)
            isSecureTextEntry = false
        default:
            break
        }
    }
    
    @objc private func toggleSecure(){
        isSecureTextEntry.toggle()
    }
    
}

extension TextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch type {
        case .phone:
            let text = (textField.text ?? "")
            if string.isEmpty {
                // Backspace was pressed, allow the deletion
                return true
            }
            return !(text.digits.count == 12)
        default:
            return true
        }
    }
    
    @objc
    func reformatAsCardNumberOrPhoneNumber(textField: UITextField) {
        var targetCursorPosition = 0
        if let startPosition = textField.selectedTextRange?.start {
            targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: startPosition)
        }
        
        var cardNumberWithoutSpaces = ""
        if var text = textField.text {
            if !text.hasPrefix("+") {
                text = "+" + text
                targetCursorPosition += 1
            }
            cardNumberWithoutSpaces = self.removeNonDigits(string: text, andPreserveCursorPosition: &targetCursorPosition)
        }
        
        
        // Format as a credit card number
        let phoneNumberWithSpaces = self.insertSpacesForPhoneNumber(cardNumberWithoutSpaces, preserveCursorPosition: &targetCursorPosition)
        textField.text = phoneNumberWithSpaces
        
        if let targetPosition = textField.position(from: textField.beginningOfDocument, offset: targetCursorPosition) {
            textField.selectedTextRange = textField.textRange(from: targetPosition, to: targetPosition)
        }
    }
    
    func removeNonDigits(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var digitsOnlyString = ""
        let originalCursorPosition = cursorPosition
        
        for (i, characterToAdd) in string.enumerated() {
            if characterToAdd >= "0" && characterToAdd <= "9" {
                digitsOnlyString.append(characterToAdd)
            } else if characterToAdd == "+" && i == 0 {
                digitsOnlyString.append(characterToAdd)
            } else if i < originalCursorPosition {
                cursorPosition -= 1
            }
        }
        
        return digitsOnlyString
    }
    
    func insertSpacesForPhoneNumber(_ string: String, preserveCursorPosition cursorPosition: inout Int) -> String {
        var stringWithAddedSpaces = ""
        let cursorPositionInSpacelessString = cursorPosition
        
        for i in 0..<string.count {
            if i == 4 || i == 6 || i == 9 || i == 11 {
                stringWithAddedSpaces.append(" ")
                
                if i < cursorPositionInSpacelessString {
                    cursorPosition += 1
                }
            }
            
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            stringWithAddedSpaces.append(characterToAdd)
        }
        
        return stringWithAddedSpaces
    }
    
}
