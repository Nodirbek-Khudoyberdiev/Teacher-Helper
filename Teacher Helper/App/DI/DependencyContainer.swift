//
//  DependencyContainer.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 08/12/23.
//

import Foundation

protocol DependencyContainerProtocol: ViewModelFactory, ViewControllerFactory, WorkerFactory {
    var networkClient: APIClientProtocol { get }
    var authService: AuthServiceProtocol { get }
}


final class DependencyContainer: DependencyContainerProtocol {
    
    private init() { }
    
    static let shared = DependencyContainer()
    
    lazy var networkClient: APIClientProtocol = APIClient()
    lazy var authService: AuthServiceProtocol = AuthService(netowrking: networkClient)
}

// MARK: ViewController DI

extension DependencyContainer {
    
    func loginVC() -> LoginVC {
        let vc = LoginVC(viewModel: loginViewModel())
        return vc
    }
    
}

// MARK: Workers DI

extension DependencyContainer {
    
    func loginWorker() -> LoginWorkerProtocol {
        return LoginWorker(authService: authService)
    }
}

// MARK: ViewModels DI

extension DependencyContainer {
    
    func loginViewModel() -> LoginViewModelProtocol {
        return LoginViewModel(worker: loginWorker())
    }
    
}
