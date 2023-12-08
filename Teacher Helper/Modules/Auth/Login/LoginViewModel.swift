//
//  LoginViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift
import RxRelay
import RxCocoa

enum AuthType {
    case local
    case google
    case facebook
}

protocol LoginViewModelProtocol {
    var buttonEnabled: Observable<Bool> { get }
    var openRegister: PublishSubject<Void> { get }
    var username: BehaviorRelay<String?> { get }
    var password: BehaviorRelay<String?> { get }
    func login(type: AuthType) -> Driver<NetworkResult<LoginResponse>>
}

extension LoginViewModelProtocol {
    func login(type: AuthType = .local) -> Driver<NetworkResult<LoginResponse>> {
        return login(type: type)
    }
}

class LoginViewModel: LoginViewModelProtocol {
    
    lazy var username = BehaviorRelay<String?>(value: nil)
    lazy var password = BehaviorRelay<String?>(value: nil)
    lazy var openRegister = PublishSubject<Void>()
    
    var buttonEnabled: Observable<Bool> {
        return Observable.combineLatest(username, password){ username, password in
            if let username = username, let password = password {
                return username.isValid(valueType: .email) && (password.count >= 8)
            }
            return false
        }
    }
    
    let worker: LoginWorkerProtocol
    
    init(worker: LoginWorkerProtocol) {
        self.worker = worker
    }
    
    func login(type: AuthType) -> Driver<NetworkResult<LoginResponse>> {
        return worker.loginUser(type: type, userName: username.value!, password: password.value!)
            .asDriver(onErrorJustReturn: .error(.init(status: nil, message: nil, code: nil)))
    }
}

