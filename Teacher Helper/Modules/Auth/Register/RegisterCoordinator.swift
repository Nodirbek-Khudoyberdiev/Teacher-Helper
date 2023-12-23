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
        let viewController = di.registerVC()
        
        viewController.viewModel.openLogin
            .subscribe(onNext: {[weak self] in
                self?.openLogin()
            })
            .disposed(by: disposeBag)
        
        viewController.viewModel.openOtp
            .flatMap({ userName in
                self.openOtp(userName: userName)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.empty()
    }
    
    private func openLogin(){
        rootViewController.navigationController?.popViewController(animated: true)
    }
    
    private func openOtp(userName: String) -> Observable<Void> {
        let coordinator = OtpCoordinator(rootViewController: rootViewController, userName: userName)
        return coordinate(to: coordinator)
    }
    
    
    
}
