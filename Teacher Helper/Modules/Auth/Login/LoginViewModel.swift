//
//  LoginViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 07/12/23.
//

import RxSwift
import RxRelay
import RxCocoa

protocol LoginViewModelProtocol: AuthViewModelProtocol {
    var openRegister: PublishSubject<Void> { get }
    func login(type: AuthType) -> Driver<NetworkResult<LoginResponse>>
}

extension LoginViewModelProtocol {
    func login(type: AuthType = .local) -> Driver<NetworkResult<LoginResponse>> {
        return login(type: type)
    }
}

class LoginViewModel: LoginViewModelProtocol {
    lazy var loadingPublisher = PublishSubject<Bool>()
    lazy var username = BehaviorRelay<String?>(value: nil)
    lazy var password = BehaviorRelay<String?>(value: nil)
    lazy var openRegister = PublishSubject<Void>()
    
    var loading: Driver<Bool> {
        return loadingPublisher
            .asDriver(onErrorJustReturn: false)
    }
    
    var buttonEnabled: Observable<Bool> {
        return Observable.combineLatest(username, password){ username, password in
            if let username = username, let password = password {
                return username.isValid(valueType: .email) && (password.count >= 8)
            }
            return false
        }
    }
    
    let worker: AuthWorkerProtocol
    
    init(worker: AuthWorkerProtocol) {
        self.worker = worker
    }
    
    func login(type: AuthType) -> Driver<NetworkResult<LoginResponse>> {
        loadingPublisher.onNext(type == .local)
        return worker.loginUser(type: type, userName: username.value!, password: password.value!)
            .asDriver(onErrorJustReturn: .error(globalDefaultError))
            .do(onNext: {[weak self] _ in
                self?.loadingPublisher.onNext(false)
            })
    }
}

