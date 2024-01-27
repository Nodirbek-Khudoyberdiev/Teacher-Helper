//
//  SubjectDetailCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 27/01/24.
//

import RxSwift

class SubjectDetailCoordinator: ReactiveCoordinator<Void> {
    let rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<Void> {
        let vc = di.subjectDetailScreen()
        
        rootViewController.navigationController?.pushViewController(vc, animated: true)
        return Observable.empty()
    }
}
