//
//  String + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import Foundation

let localFormatPhone = "+XXX XX XXX XX XX"
let maskedFormatPhone = "+XXX XX *** ** XX"

extension String {
    static func localized(_ strings: Strings) -> String {
        return Localization.getValue(strings)
    }
}

extension String? {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

}

extension String {
    
    var replaceSpace: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var digits: String {
           return components(separatedBy: CharacterSet.decimalDigits.inverted)
               .joined()
       }
    
    /// For formatting phone number
    /// - Parameters:
    ///   - mask: +XXX XX XXX-XX XX
    /// - Returns: formatted phone number
    func format(with mask: String = localFormatPhone, hideCharacter: Character = "*") -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9+]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else if ch == hideCharacter {
                // replace with the specified hide character
                result.append(hideCharacter)
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }

    
    var isPhoneNumber: Bool {
        return self.hasPrefix("+998") || self.hasPrefix("998")
    }
    
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
