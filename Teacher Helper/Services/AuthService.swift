//
//  AuthService.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift

protocol AuthServiceProtocol {
    func login(userName: String, password: String) -> Single<BaseResponse<LoginResponse>>
}

class AuthService: AuthServiceProtocol {
    
    private let netowrking: APIClientProtocol
    
    init(netowrking: APIClientProtocol) {
        self.netowrking = netowrking
    }
    
    func login(userName: String, password: String) -> Single<BaseResponse<LoginResponse>> {
        let authEndpoint = AuthEndpoint.login(username: userName, password: password)
        return netowrking.request(type: LoginResponse.self, endpoint: authEndpoint)
            .asSingle()
    }
    
}
