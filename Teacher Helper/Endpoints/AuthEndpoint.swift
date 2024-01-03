//
//  AuthEndpoint.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 05/12/23.
//

import Foundation

enum AuthEndpoint {
    case register(userName: String, password: String)
    case login(username: String, password: String)
    case confirm(userName: String, code: String)
    case resend(username: String)
    case passwordChange(password: String)
    case logout
}

extension AuthEndpoint: Endpoint {
    
    var root: String {
        return "/auth/"
    }
    
    var path: String {
        switch self {
        case .register:
            return "register"
        case .login:
            return "login"
        case .confirm:
            return "confirm"
        case .resend:
            return "resend"
        case .logout:
            return "logout"
        case .passwordChange:
            return "password/change"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var body: [String: Any]? {
        switch self {
        case .login(let userName, let password):
            return [
                "username": userName,
                "password": password
            ]
        case .register(let userName, let password):
            return [
                "username": userName,
                "password": password
            ]
        case .confirm(let userName, let code):
            return [
                "username": userName,
                "code": code
            ]
        case .resend(let username):
            return [
                "username": username
            ]
        case .passwordChange(let password):
            return [
                "password": password
            ]
        case .logout:
            return [:]
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .passwordChange(let password):
            return [
                "Content-Type":"application/json",
                "locale": UserDefaults.standard.getLocaleCode(),
                "Authorization": "Bearer \(KeychainStore.token ?? "")"
            ]
        default:
            return [
                "Content-Type":"application/json",
                "locale": UserDefaults.standard.getLocaleCode()
            ]
        }
    }
}



