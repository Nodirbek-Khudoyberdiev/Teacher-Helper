//
//  UserDefaults + Ext.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import Foundation

extension UserDefaults {
    enum Keys {
        static let localeCode = "locale_code"
        static let languageSaved = "languageSaved"
        static let alreadyInstalled = "alreadyInstalled"
    }
}

extension UserDefaults {
    
    func setLanguageSaved(_ value: Bool) {
        setValue(value, forKey: Keys.languageSaved)
    }
    
    func getLanguageSaved() -> Bool {
        return bool(forKey: Keys.languageSaved)
    }
    
    func saveLocaleCode(languageCode: Localization) {
        setLanguageSaved(true)
        setValue(languageCode.rawValue, forKey: Keys.localeCode)
    }
    
    
    func getLocaleCode() -> String {
        if let lang = string(forKey: Keys.localeCode) {
            return lang
        }
        
        if let currentLanguage = Locale.current.languageCode {
            if currentLanguage == Localization.RUSSIAN.rawValue {
                return Localization.RUSSIAN.rawValue
            }
            if currentLanguage == Localization.UZ.rawValue {
                return Localization.UZ.rawValue
            }
        }
        return Localization.ENGLISH.rawValue
    }
    
    func clearKeychainIfWillUnistall() {
        let freshInstall = !bool(forKey: Keys.alreadyInstalled)
        if freshInstall {
            KeychainStore.clearKeychain()
            set(true, forKey: Keys.alreadyInstalled)
        }
    }
}
