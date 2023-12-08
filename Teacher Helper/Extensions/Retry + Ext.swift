//
//  Retry.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/12/23.
//

import RxSwift
import RxCocoa
import Alamofire
import Reachability

//enum RetryingErrorCodes: Int {
//    case gatewayTimeout = 504
//    case timeOut = 408
//    case noConnection = -1020
//    case badGateWay = 502
//}

extension ObservableType {
    func retry<E>(_ maxAttemptCount: Int = Int.max,
                   delay: DelayOptions,
                   didBecomeReachable: Signal<Void> = ReachabilityRx.shared.didBecomeReachable,
                   shouldRetry: @escaping (Error) -> Bool = { _ in true }) -> Observable<E> where E == Element {
        return retry(when:  { (errors: Observable<Error>) in
            return errors.enumerated().flatMap { attempt, error -> Observable<Void> in
                guard maxAttemptCount > attempt + 1, shouldRetry(error) else {
                    return .error(error)
                }

                if let statusCode = (error as? URLError)?.code {
                    if statusCode.rawValue == 401 {
                        // Handle 401 (Unauthorized) - Return to Login Page or take appropriate action
                        // Example: You might want to post a notification to trigger a login screen presentation
                        // NotificationCenter.default.post(name: .userUnauthorized, object: nil)
                        return .error(error)
                    } else if (400...500).contains(statusCode.rawValue) {
                        // Return error for other 4xx and 5xx status codes
                        return .error(error)
                    } else {
                        // Retry for other status codes
                        let timer = Observable<Int>.timer(
                            .seconds(Int(delay.make(attempt + 1))),
                            scheduler: MainScheduler.instance
                        ).map { _ in () } // cast to Observable<Void>
                        return Observable.merge(timer, didBecomeReachable.asObservable())
                    }
                }
                return .error(error)
            }
        })
        .map { $0 }
    }
}





enum DelayOptions {
    case immediate(Void)
    case constant(time: Double)
    case exponential(initial: Double, multiplier: Double, maxDelay: Double)
    case custom(closure: (Int) -> Double)
}

extension DelayOptions {
    func make(_ attempt: Int) -> Double {
        switch self {
        case .immediate: return 0.0
        case .constant(let time): return time
        case .exponential(let initial, let multiplier, let maxDelay):
            // if it's first attempt, simply use initial delay, otherwise calculate delay
            let delay = attempt == 1 ? initial : initial * pow(multiplier, Double(attempt - 1))
            return min(maxDelay, delay)
        case .custom(let closure): return closure(attempt)
        }
    }
}


final class ReachabilityRx {
    static let shared = ReachabilityRx()

    private let reachability = NetworkReachabilityManager()

    var didBecomeReachable: Signal<Void> { return _didBecomeReachable.asSignal() }
    private let _didBecomeReachable = PublishRelay<Void>()

    init() {
        if let reachability {
            reachability.startListening(onQueue: .main) {[weak self] status in
                self?.update(status)
            }
        }
    }

    private func update(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        if case .reachable = status {
            _didBecomeReachable.accept(())
        }
    }
}

/// example

/*
 pipeline.rx.loadImage(with: request).asObservable()
     .retry(3, delay: .exponential(initial: 3, multiplier: 1, maxDelay: 16))
     .subscribe(onNext: { imageView.image = $0.image })
     .disposed(by: disposeBag)
 */

