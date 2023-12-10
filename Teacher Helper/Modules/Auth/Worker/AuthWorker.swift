//
//  AuthWorker.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift

protocol AuthWorkerProtocol {
    func loginUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<LoginResponse>>
    func registerUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<RegisterResponse>>
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
    
    func registerUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<RegisterResponse>> {
        return authService.register(userName: userName, password: password)
    }
}
