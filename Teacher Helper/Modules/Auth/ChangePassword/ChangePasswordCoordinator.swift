//
//  ChangePasswordCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/01/24.
//

import RxSwift

class ChangePasswordCoordinator: ReactiveCoordinator<Void> {
    
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<Void> {
        let vc = di.changePasswordVC()
        
        vc.viewModel.passwordChanged
            .observeOnMain()
            .subscribe(onNext: { _ in
                let vc = PasswordChangedVC()
                self.rootViewController.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        rootViewController.navigationController?.pushViewController(vc, animated: true)
        
        return Observable.just(())
    }
}
