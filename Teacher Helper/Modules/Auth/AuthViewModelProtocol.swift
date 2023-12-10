//
//  AuthViewModelProtocol.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 11/12/23.
//

import RxSwift
import RxCocoa
import RxRelay

enum AuthType {
    case local
    case google
    case facebook
}

protocol AuthViewModelProtocol {
    var loading: Driver<Bool> { get }
    var buttonEnabled: Observable<Bool> { get }
    var username: BehaviorRelay<String?> { get }
    var password: BehaviorRelay<String?> { get }
}
