//
//  ResourcesService.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 28/01/24.
//

import RxSwift
import RxRelay

protocol ResourcesServiceProtocol {
    func getAllResources() -> Observable<NetworkResult<[Resources]>>
}

class ResourcesService: ResourcesServiceProtocol {
    
    private let networking: APIClientProtocol
    
    init(networking: APIClientProtocol) {
        self.networking = networking
    }
    
    func getAllResources() -> Observable<NetworkResult<[Resources]>> {
        let endpoint = ResourceEndpoint.getAllResources
        return networking.request(type: [Resources].self, endpoint: endpoint)
    }
}
