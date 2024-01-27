//
//  ResourcesScreenCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import RxSwift

class ResourcesScreenCoordinator: ReactiveCoordinator<Void> {
    
    let vc = DependencyContainer.shared.resourcesScreen()
    
    private var tabbarViewController: UITabBarController?
    private var rootviewController: UIViewController?
    
    convenience init(tabbarViewController: UITabBarController) {
        self.init()
        self.tabbarViewController = tabbarViewController
        setupForTabbar()
    }
    
    convenience init(rootviewController: UIViewController){
        self.init()
        self.rootviewController = rootviewController
    }
    
    override func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<Void> {
        
        vc.didSelectSubject
            .flatMap({
                self.openSubjectDetailedVC()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.empty()
    }
    
    private func setupForTabbar(){
        guard let resourceNavVC = tabbarViewController?.createNav(with: "Ресурсы", image: .resourcesBookOpen, selectedImge: .resourcesBookOpenSelected, vc: vc) else  { return }
        tabbarViewController?.viewControllers?.append(resourceNavVC)
    }
    
    private func openSubjectDetailedVC() -> Observable<Void> {
        let coordinator = SubjectDetailCoordinator(rootViewController: vc)
        return coordinate(to: coordinator)
    }
    
}
