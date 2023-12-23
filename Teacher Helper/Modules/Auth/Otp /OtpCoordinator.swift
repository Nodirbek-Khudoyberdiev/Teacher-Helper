//
//  OtpCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 23/12/23.
//

import RxSwift

class OtpCoordinator: ReactiveCoordinator<Void> {
    let rootViewController: UIViewController
    let userName: String
    
    init(rootViewController: UIViewController, userName: String) {
        self.rootViewController = rootViewController
        self.userName = userName
    }
    
    override func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<Void> {
        let viewController = di.otpVC(userName: userName)
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.empty()
    }
}
