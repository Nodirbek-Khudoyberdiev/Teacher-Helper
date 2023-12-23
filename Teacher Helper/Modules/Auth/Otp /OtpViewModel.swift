//
//  OtpViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 23/12/23.
//

import RxSwift
import RxRelay

protocol OtpViewModelProtocol {
    var userName: String { get }
    var otpNumber: BehaviorRelay<String> { get }
    var isButtonEnabled: Observable<Bool> { get }
    
    func sendOtp() -> Observable<Void>
    
    
    init(userName: String)
}

final class OtpViewModel: OtpViewModelProtocol {
    
    let userName: String
    let otpNumber = BehaviorRelay<String>(value: "")
    
    var isButtonEnabled: Observable<Bool> {
        return otpNumber
            .asObservable()
            .map({$0.count == 6})
    }
    
    init(userName: String) {
        self.userName = userName
    }
    
    func sendOtp() -> Observable<Void> {
        return Observable.just(())
    }
    
}
