//
//  AppCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 06/12/23.
//

import RxSwift

class AppCoordinator: ReactiveCoordinator<Void> {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start(_ di: DependencyContainerProtocol) -> Observable<Void> {
        
        let coordinator = startBuilder()
        
        return coordinate(to: coordinator)
    }
    
    private func startBuilder() -> ReactiveCoordinator<Void> {
        var navVC: UINavigationController
        var coordinator: ReactiveCoordinator<Void>
        if UserDefaults.standard.getLocaleCode().isEmpty {
            let vc = LanguageChooseVC()
            navVC = UINavigationController(rootViewController: vc)
            coordinator = LanguageChooseCoordinator(rootViewController: navVC.viewControllers[0])
        } else if !KeychainStore.token.isEmptyOrNil {
            let vc = DependencyContainer.shared.mainScreen()
            navVC = UINavigationController(rootViewController: vc)
            coordinator = MainScreenCoordinator(rootViewController: navVC)
        } else {
            let vc = DependencyContainer.shared.loginVC()
            navVC = UINavigationController(rootViewController: vc)
            coordinator = LoginCoordinator(rootViewController: navVC)
        }
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        return coordinator
    }
}
