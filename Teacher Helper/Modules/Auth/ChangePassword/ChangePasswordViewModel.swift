//
//  ChangePasswordViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/01/24.
//

import RxSwift
import RxRelay
import RxCocoa

protocol ChangePasswordViewModelProtocol: AuthViewModelProtocol {
    var passwordChanged: PublishSubject<Bool> { get }
    func changePassword() -> Observable<NetworkResult<EmptyResponse>>
}

class ChangePasswordViewModel: ChangePasswordViewModelProtocol {
    
    lazy var loadingPublisher = PublishSubject<Bool>()
    lazy var passwordChanged = PublishSubject<Bool>()
    
    var loading: Driver<Bool> {
        return loadingPublisher
            .asDriver(onErrorJustReturn: false)
    }
    
    var buttonEnabled: Observable<Bool> {
        return password
            .map({($0 ?? "").count >= 8})
    }
    
    let password = BehaviorRelay<String?>(value: nil)
    
    let authWorker: AuthWorkerProtocol
    
    init(authWorker: AuthWorkerProtocol){
        self.authWorker = authWorker
    }
    
    func changePassword() -> Observable<NetworkResult<EmptyResponse>> {
        loadingPublisher.onNext(true)
        return authWorker.changePassword(password.value!)
            .asObservable()
            .do(onNext: { result in
                switch result {
                case .success:
                    self.passwordChanged.onNext(true)
                case .error:
                    break
                }
                self.loadingPublisher.onNext(false)
            })
        
    }
    
    
    
}
