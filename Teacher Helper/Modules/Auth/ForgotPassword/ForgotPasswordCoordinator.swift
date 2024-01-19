//
//  ForgotPasswordCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 02/01/24.
//

import RxSwift

class ForgotPasswordCoordinator: ReactiveCoordinator<Void> {
    
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<Void> {
        let vc = di.forgotPasswordVC()
        vc.viewModel.openOtp
            .flatMap({[unowned self] username in
                openOtp(userName: username)
            })
            .observeOnMain()
            .flatMap({ [unowned self] _ -> Observable<Void> in
                return openMainScreen()
            })
            .subscribe(onNext: {
                self.rootViewController.navigationController?.removeViewController(OtpVC.self)
            })
            .disposed(by: disposeBag)
        
        rootViewController.navigationController?.pushViewController(vc, animated: true)
        return Observable.empty()
    }
    
    private func openOtp(userName: String) -> Observable<Bool> {
        let coordinator = OtpCoordinator(rootViewController: rootViewController, userName: userName)
        return coordinate(to: coordinator)
    }
    
    private func openMainScreen() -> Observable<Void> {
        let coordinator = ChangePasswordCoordinator(rootViewController: rootViewController)
        return coordinate(to: coordinator)
    }
}
