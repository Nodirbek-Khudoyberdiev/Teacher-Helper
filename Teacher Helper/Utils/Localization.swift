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
    
    private static func getValue(_ key: String, comment: String?) -> String {
        let localCode = UserDefaults.standard.getLocaleCode()
        let path = Bundle.main.path(forResource: localCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return bundle!.localizedString(forKey: key, value: comment, table: nil)
    }
    
    static func getValue(_ key: Strings) -> String {
        return self.getValue(key.rawValue, comment: key.rawValue)
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
