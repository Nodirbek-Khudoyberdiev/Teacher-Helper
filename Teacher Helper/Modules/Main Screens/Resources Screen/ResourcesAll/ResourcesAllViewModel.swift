//
//  ResourcesAllViewModel.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 28/01/24.
//

import RxSwift
import RxRelay

protocol ResourcesAllViewModelProtocol {
    var resources: PublishSubject<[ResourcesAllVM]> { get }
    func getAllResources()
}

class ResourcesAllViewModel: ResourcesAllViewModelProtocol {
    
    lazy var resources = PublishSubject<[ResourcesAllVM]>()
    let bag = DisposeBag()
    let worker: ResourcesWorkerProtocol
    
    init(worker: ResourcesWorkerProtocol) {
        self.worker = worker
        getAllResources()
    }
    
    func getAllResources(){
        worker.getAllResources()
            .compactMap({$0})
            .bind(to: resources)
            .disposed(by: bag)
    }
    
}
