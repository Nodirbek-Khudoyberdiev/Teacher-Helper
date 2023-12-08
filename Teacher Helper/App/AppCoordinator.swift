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
        
        let navigationController = UINavigationController(rootViewController: LanguageChooseVC())
        
        let languageChooseCoordinator = LanguageChooseCoordinator(rootViewController: navigationController.viewControllers[0])
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return coordinate(to: languageChooseCoordinator)
    }
}
