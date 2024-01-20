//
//  LoginCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import RxSwift

class LoginCoordinator: ReactiveCoordinator<Void> {
    
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start(_ di: DependencyContainerProtocol) -> Observable<Void> {
        let viewController = di.loginVC()
        viewController
            .viewModel.openRegister
            .flatMap({ [unowned self] in
                openRegister()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        viewController
            .viewModel.openForgotPassword
            .flatMap({ [unowned self] in
                openForgotPassword()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        viewController.viewModel
            .loginSucceed
            .flatMap({
                self.openMainScreen()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.empty()
    }
    
    private func openRegister() -> Observable<Void> {
        let loginCoordinator = RegisterCoordinator(rootViewController: rootViewController)
        return coordinate(to: loginCoordinator)
    }
    
    private func openForgotPassword() -> Observable<Void> {
        let forgotPasswordCoordinator = ForgotPasswordCoordinator(rootViewController: rootViewController)
        return coordinate(to: forgotPasswordCoordinator)
    }
    
    private func openMainScreen() -> Observable<Void> {
        let coordinator = MainScreenCoordinator(rootViewController: rootViewController)
        return coordinate(to: coordinator)
    }
    
}
