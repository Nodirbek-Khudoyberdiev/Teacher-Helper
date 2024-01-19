//
//  AuthService.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift

protocol AuthServiceProtocol {
    func login(userName: String, password: String) -> Single<NetworkResult<LoginResponse>>
    func register(userName: String, password: String) -> Single<NetworkResult<EmptyResponse>>
    func resendOtp(userName: String) -> Single<NetworkResult<EmptyResponse>>
    func confirmOtp(userName: String, code: String) -> Single<NetworkResult<LoginResponse>>
    func changePassword(_ password: String) -> Single<NetworkResult<EmptyResponse>>
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
    
    func register(userName: String, password: String) -> Single<NetworkResult<EmptyResponse>> {
        let authEndpoint = AuthEndpoint.register(userName: userName, password: password)
        return networking.request(type: EmptyResponse.self, endpoint: authEndpoint)
            .asSingle()
    }

    func confirmOtp(userName: String, code: String) -> Single<NetworkResult<LoginResponse>> {
        let authEndpoint = AuthEndpoint.confirm(userName: userName, code: code)
        return networking.request(type: LoginResponse.self, endpoint: authEndpoint)
            .asSingle()
            
    }
    
    func resendOtp(userName: String) -> Single<NetworkResult<EmptyResponse>> {
        let authEndpoint = AuthEndpoint.resend(username: userName)
        return networking.request(type: EmptyResponse.self, endpoint: authEndpoint)
            .asSingle()
    }
    
    func changePassword(_ password: String) -> Single<NetworkResult<EmptyResponse>> {
        let authEndpoint = AuthEndpoint.passwordChange(password: password)
        return networking.request(type: EmptyResponse.self, endpoint: authEndpoint)
            .asSingle()
    }
    
}
