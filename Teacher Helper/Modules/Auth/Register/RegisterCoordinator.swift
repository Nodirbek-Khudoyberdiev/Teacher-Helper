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
        
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.empty()
    }
    
    private func openLogin(){
        rootViewController.navigationController?.popViewController(animated: true)
    }
    
    
    
}
