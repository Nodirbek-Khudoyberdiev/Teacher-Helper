//
//  String + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import Foundation

extension String {
    var localized: String {
        return Localization.getValue(self)
    }
}

extension String? {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

}

extension String {
    enum ValidTypes {
        case name
        case email
        case password
    }
    
    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[A-Za-z]{2,64}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,50}"
    }
    
    func isValid(valueType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch valueType {
        case .name:
            regex = Regex.name.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
