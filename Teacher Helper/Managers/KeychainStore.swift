//
//  KeychainStore.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import KeychainAccess

@propertyWrapper
struct KeychainValue {

    let key: String

    var wrappedValue: String? {
        get { KeychainStore.keychain[key] }
        set { KeychainStore.keychain[key] = newValue }
    }
}

struct KeychainStore {
    fileprivate static let keychain = Keychain()
    
    enum Keys {
        static let token = "token"
        static let pinCode = "pinCode"
    }
    
    @KeychainValue(key: Keys.token)
    static var token: String?
    
    @KeychainValue(key: Keys.pinCode)
    static var pinCode: String?
    
    static func clearKeychain(){
        token = nil
        pinCode = nil
        try? keychain.removeAll()
    }
    
}

