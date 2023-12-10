//
//  AuthService.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift

protocol AuthServiceProtocol {
    func login(userName: String, password: String) -> Single<NetworkResult<LoginResponse>>
    func register(userName: String, password: String) -> Single<NetworkResult<RegisterResponse>>
}

class AuthService: AuthServiceProtocol {
    
    private let networking: APIClientProtocol
    
    init(networking: APIClientProtocol) {
        self.networking = networking
    }
    
    func login(userName: String, password: String) -> Single<NetworkResult<LoginResponse>> {
        let authEndpoint = AuthEndpoint.login(username: userName, password: password)
        return networking.request(type: LoginResponse.self, endpoint: authEndpoint)
            .asSingle()
    }
    
    func register(userName: String, password: String) -> Single<NetworkResult<RegisterResponse>> {
        let authEndpoint = AuthEndpoint.register(firstName: "", lastName: "", userName: userName, password: password, region: 1, city: 187)
        return networking.request(type: RegisterResponse.self, endpoint: authEndpoint)
            .asSingle()
    }
    
}
