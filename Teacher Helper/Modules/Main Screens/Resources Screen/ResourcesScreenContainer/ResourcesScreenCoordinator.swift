//
//  ResourcesScreenCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import RxSwift

class ResourcesScreenCoordinator: ReactiveCoordinator<Void> {
    
    let vc = DependencyContainer.shared.resourcesScreen()
    private var rootviewController: UIViewController?
    
    convenience init(rootviewController: UIViewController){
        self.init()
        self.rootviewController = rootviewController
    }
    
    override func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<Void> {
        
        vc.didSelectAllSubject
            .flatMap({
                self.openSubjectDetailedVC($0)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        return Observable.empty()
    }

    
    private func openSubjectDetailedVC(_ vm: ResourcesAllVM) -> Observable<Void> {
        let coordinator = SubjectDetailCoordinator(rootViewController: vc)
        return coordinate(to: coordinator)
    }
    
}
