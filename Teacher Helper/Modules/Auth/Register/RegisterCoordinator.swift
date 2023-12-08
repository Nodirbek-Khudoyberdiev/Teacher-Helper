//
//  RegisterCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import RxSwift

class RegisterCoordinator: ReactiveCoordinator<Void> {
    
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start(_ di: DependencyContainerProtocol) -> Observable<Void> {
        let viewController = RegisterVC()
//        viewController
//            .loginFinished
//            .flatMap({ [unowned self] in
//                
//            })
//            .subscribe()
//            .disposed(by: disposeBag)
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.empty()
    }
    
//    private func openRegister() -> Observable<Void> {
//        let loginCoordinator = RegisterCoordinator(rootViewController: rootViewController)
//        return coordinate(to: loginCoordinator)
//    }
    
}
