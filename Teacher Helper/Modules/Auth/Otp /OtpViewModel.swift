//
//  OtpViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 23/12/23.
//

import RxSwift
import RxRelay
import RxCocoa

protocol OtpViewModelProtocol {
    var userName: String { get }
    var otpNumber: BehaviorRelay<String> { get }
    
    var isButtonEnabled: Observable<Bool> { get }
    var loading: Driver<Bool> { get }
    var codeConfirmed: PublishSubject<Bool> { get }
    
    func confirmOtp() -> Observable<NetworkResult<LoginResponse>>
    func resendOtp() -> Observable<Void>
}

final class OtpViewModel: OtpViewModelProtocol {
    
    let userName: String
    let otpNumber = BehaviorRelay<String>(value: "")
    let loadingPublisher = PublishSubject<Bool>()
    let codeConfirmed = PublishSubject<Bool>()
    let authWorker: AuthWorkerProtocol
    var loading: Driver<Bool> {
        return loadingPublisher
            .asDriver(onErrorJustReturn: false)
    }
    
    var isButtonEnabled: Observable<Bool> {
        return otpNumber
            .asObservable()
            .map({$0.count == 6})
    }
    
    init(authWorker: AuthWorkerProtocol, userName: String) {
        self.authWorker = authWorker
        self.userName = userName
    }
    
    func confirmOtp() -> Observable<NetworkResult<LoginResponse>> {
        loadingPublisher.onNext(true)
        return authWorker
            .confirmOtp(username: userName, code: otpNumber.value)
            .do(onSuccess: { _ in
                self.codeConfirmed.onNext(true)
                self.loadingPublisher.onNext(false)
            }, onError: { _ in
                self.loadingPublisher.onNext(false)
            })
            .asObservable()
    }
    
    func resendOtp() -> Observable<Void> {
        return authWorker.resend(username: userName)
            .asObservable()
            .flatMap({ _ -> Observable<Void> in
                return Observable.just(())
            })
    }
    
}
