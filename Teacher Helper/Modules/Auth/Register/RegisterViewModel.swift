//
//  RegisterViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/12/23.
//

import RxSwift
import RxRelay
import RxCocoa

protocol RegisterViewModelProtocol: AuthViewModelProtocol {
    var openLogin: PublishSubject<Void> { get }
    var openOtp: PublishSubject<String> { get }
    func register(type: AuthType) -> Driver<NetworkResult<EmptyResponse>>
}

extension RegisterViewModelProtocol {
    func register(type: AuthType = .local) -> Driver<NetworkResult<EmptyResponse>> {
        return register(type: type)
    }

}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    lazy var loadingPublisher = PublishSubject<Bool>()
    
    var loading: Driver<Bool> {
        return loadingPublisher
            .asDriver(onErrorJustReturn: false)
    }
    
    lazy var username = BehaviorRelay<String?>(value: nil)
    lazy var password = BehaviorRelay<String?>(value: nil)
    
    lazy var openOtp = PublishSubject<String>()
    lazy var openLogin = PublishSubject<Void>()
    
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
    
    func register(type: AuthType) -> Driver<NetworkResult<EmptyResponse>> {
        loadingPublisher.onNext(true)
        return worker.registerUser(type: type, userName: username.value!, password: password.value!)
            .asDriver(onErrorJustReturn: .error(globalDefaultError))
            .do(onNext: {[weak self] _ in
                guard let self else { return }
                let userName = self.username.value ?? ""
                self.openOtp.onNext(userName)
                self.loadingPublisher.onNext(false)
            })
    }
    
}
