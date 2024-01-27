//
//  ResourcesWorker.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 28/01/24.
//

import RxSwift

protocol ResourcesWorkerProtocol {
    func getAllResources() -> Observable<[ResourcesAllVM]?>
}

class ResourcesWorker: ResourcesWorkerProtocol {
    
    let resourcesService: ResourcesServiceProtocol
    
    init(resourcesService: ResourcesServiceProtocol) {
        self.resourcesService = resourcesService
    }
    
    func getAllResources() -> Observable<[ResourcesAllVM]?> {
        return resourcesService.getAllResources()
            .map({ response in
                
                switch response {
                case .success(let resources):
                    var resourcesVM: [ResourcesAllVM] = []
                    resources.data?.forEach { resource in
                        let vm = ResourcesAllVM(courseName: resource.topic?.add?.science ?? "", courseClasses: resource.topic?.add?.grade ?? "")
                        resourcesVM.append(vm)
                    }
                    return resourcesVM
                case .error:
                    return []
                }
            })
    }
    
}
