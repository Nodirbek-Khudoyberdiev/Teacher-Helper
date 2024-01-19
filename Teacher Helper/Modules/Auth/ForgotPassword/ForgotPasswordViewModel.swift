//
//  ForgotPasswordViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 02/01/24.
//

import RxSwift
import RxRelay
import RxCocoa

protocol ForgotPasswordViewModelProtocol: AuthViewModelProtocol {
    var openOtp: PublishSubject<String> { get }
    var username: BehaviorRelay<String?> { get }
    func sendOtp() -> Driver<NetworkResult<EmptyResponse>>
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    
    let loadingPublisher = PublishSubject<Bool>()
    var buttonEnabled: Observable<Bool> {
        return username
            .map({$0?.count == 12})
    }
    
    var loading: Driver<Bool> {
        return loadingPublisher.asDriver(onErrorJustReturn: false)
    }
    
    let openOtp = PublishSubject<String>()
    let username = BehaviorRelay<String?>(value: nil)
    
    let worker: AuthWorkerProtocol
    
    init(worker: AuthWorkerProtocol) {
        self.worker = worker
    }
    
    func sendOtp() -> Driver<NetworkResult<EmptyResponse>> {
        let username = username.value ?? ""
        loadingPublisher.onNext(true)
        return worker.resend(username: username)
            .asDriver(onErrorJustReturn: .error(globalDefaultError))
            .do(onNext: {[weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    let userName = username
                    self.openOtp.onNext(userName)
                case .error:
                    break
                }
                self.loadingPublisher.onNext(false)
            })
    }
    
}
