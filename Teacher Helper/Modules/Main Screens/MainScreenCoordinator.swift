//
//  MainScreenCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 20/01/24.
//

import RxSwift

class MainScreenCoordinator: ReactiveCoordinator<Void> {
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<Void> {
        let viewController = di.mainScreen()
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.never()
    }
}

