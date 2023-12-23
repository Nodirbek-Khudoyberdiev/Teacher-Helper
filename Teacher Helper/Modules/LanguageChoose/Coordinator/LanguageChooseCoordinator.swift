//
//  LanguageChooseCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import RxSwift

class LanguageChooseCoordinator: ReactiveCoordinator<Void> {
    
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start(_ di: DependencyContainerProtocol) -> Observable<Void> {
        
        let viewController = rootViewController as! LanguageChooseVC
        
        viewController.languageChoosed
            .flatMap({ [unowned self] in
                coordinateToLogin()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.empty()
    }
    
    // MARK: - Coordination
    private func coordinateToLogin() -> Observable<Void> {
        let loginCoordinator = LoginCoordinator(rootViewController: rootViewController)
        return coordinate(to: loginCoordinator)
    }
    
}

