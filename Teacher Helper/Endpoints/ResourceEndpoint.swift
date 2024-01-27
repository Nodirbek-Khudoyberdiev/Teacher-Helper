//
//  ResourceEndpoint.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 28/01/24.
//

import Foundation

enum ResourceEndpoint {
    case getAllResources
}

extension ResourceEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getAllResources:
            return "list"
        }
    }
    
    var root: String {
        "/teacher/resource/"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var body: [String : Any]? {
        nil
    }
    
    var headers: [String : String] {
        [
            "Content-Type":"application/json",
            "locale": UserDefaults.standard.getLocaleCode(),
            "Authorization": "Bearer \(KeychainStore.token ?? "")"
        ]
    }
    
    
}
