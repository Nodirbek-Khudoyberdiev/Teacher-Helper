//
//  NetworkChecker.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 09/12/23.
//

import Network
import RxSwift
import RxCocoa

final class NetworkChecker {
    
    static let shared = NetworkChecker()
    private var checkInternetPublisher = PublishSubject<Bool>()
    var checkInternet: Driver<Bool> {
        return checkInternetPublisher
            .asDriver(onErrorJustReturn: false)
    }
    
    private init(){}
    
    func monitorNetwork(){
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = {[weak self] path in
            guard let self = self else { return }
            let status = path.status == .satisfied
            self.checkInternetPublisher.onNext(status)
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}
