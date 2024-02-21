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
        UserDefaults.standard.clearKeychainIfWillUnistall()
        let coordinator = startBuilder()
        return coordinate(to: coordinator)
    }
    
    private func startBuilder() -> ReactiveCoordinator<Void> {
        var coordinator: ReactiveCoordinator<Void>
        if !KeychainStore.token.isEmptyOrNil {
            let vc = DependencyContainer.shared.mainScreen()
            coordinator = MainScreenCoordinator(rootViewController: vc)
            window.rootViewController = vc
        } else {
            let vc = LanguageChooseVC()
            let navVC = UINavigationController(rootViewController: vc)
            coordinator = LanguageChooseCoordinator(rootViewController: vc)
            window.rootViewController = navVC
        }
        window.makeKeyAndVisible()
        return coordinator
    }
}
