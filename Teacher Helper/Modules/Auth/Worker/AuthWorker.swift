//
//  AuthWorker.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift

protocol AuthWorkerProtocol {
    func loginUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<LoginResponse>>
    func registerUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<EmptyResponse>>
    func confirmOtp(username: String, code: String) -> Single<NetworkResult<LoginResponse>>
    func resend(username: String) -> Single<NetworkResult<EmptyResponse>>
}

class AuthWorker: AuthWorkerProtocol {
    
    let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func loginUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<LoginResponse>> {
        return authService.login(userName: userName, password: password)
            .do(onSuccess: { result in
                switch result {
                case .success(let loginResponse):
                    KeychainStore.token = loginResponse.data?.token
                case .error:
                    break
                }
            })
    }
    
    func registerUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<EmptyResponse>> {
        return authService.register(userName: userName, password: password)
    }
    
    func confirmOtp(username: String, code: String) -> Single<NetworkResult<LoginResponse>> {
        return authService.confirmOtp(userName: username, code: code)
            .do(onSuccess: { result in
                switch result {
                case .success(let loginResponse):
                    KeychainStore.token = loginResponse.data?.token
                case .error:
                    break
                }
            })
    }
    
    func resend(username: String) -> Single<NetworkResult<EmptyResponse>> {
        return authService.resendOtp(userName: username)
    }
}
