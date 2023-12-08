//
//  AuthEndpoint.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 05/12/23.
//

import Foundation

enum AuthEndpoint {
    case register(firstName: String, lastName: String, userName: String, password: String, region: Int, city: Int)
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
        case .register(let firstName, let lastName, let userName, let password, let region, let city):
            return [
                "first_name": firstName,
                "last_name": lastName,
                "username": userName,
                "password": password,
                "region": region,
                "city": city
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
        return [
            "Content-Type":"application/json"
        ]
    }
}



