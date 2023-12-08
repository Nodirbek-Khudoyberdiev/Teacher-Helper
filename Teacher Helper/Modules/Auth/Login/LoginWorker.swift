//
//  LoginWorker.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift

protocol LoginWorkerProtocol {
    func loginUser(type: AuthType, userName: String, password: String) -> Single<BaseResponse<LoginResponse>>
}

class LoginWorker: LoginWorkerProtocol {
    
    let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func loginUser(type: AuthType, userName: String, password: String) -> Single<BaseResponse<LoginResponse>> {
        return authService.login(userName: userName, password: password)
            .do(onSuccess: { loginResponse in
                KeychainStore.token = loginResponse.data?.token
            })
    }
}
