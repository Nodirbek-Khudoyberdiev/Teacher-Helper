//
//  LoginWorker.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift

protocol LoginWorkerProtocol {
    func loginUser(type: AuthType, userName: String, password: String) -> Single<NetworkResult<LoginResponse>>
}

class LoginWorker: LoginWorkerProtocol {
    
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
}
