//
//  Localization.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import Foundation

enum Localization: String {
    case ENGLISH = "en"
    case RUSSIAN = "ru"
    case UZ = "uz"
    case UzCyrclic = "uz-Cyrl"
    
    private static var language: String = UserDefaults.standard.getLocaleCode() //"en-US"
    
    private static func getValue(_ key: String, comment: String?) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle!.localizedString(forKey: key, value: comment, table: nil)
    }
    
    static func getValue(_ key: String) -> String {
        return self.getValue(key, comment: key)
    }
    
    var title: String {
        switch self {
        case .ENGLISH:
            return "English"
        case .UZ:
            return "O'zbekcha"
        case .RUSSIAN:
            return "Русский"
        case .UzCyrclic:
            return "Ўзбекча"
        }
    }
    
}
