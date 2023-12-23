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
    lazy var authService: AuthServiceProtocol = AuthService(networking: networkClient)
}

// MARK: ViewController DI

extension DependencyContainer {
    
    func loginVC() -> LoginVC {
        let vc = LoginVC(viewModel: loginViewModel())
        return vc
    }
    
    func registerVC() -> RegisterVC {
        return RegisterVC(viewModel: registerViewModel())
    }
 
    func otpVC(userName: String) -> OtpVC {
        let viewModel = otpViewModel(userName: userName)
        return OtpVC(viewModel: viewModel)
    }
    
}

// MARK: Workers DI

extension DependencyContainer {
    
    func authWorker() -> AuthWorkerProtocol {
        return AuthWorker(authService: authService)
    }
    
}

// MARK: ViewModels DI

extension DependencyContainer {
    
    func loginViewModel() -> LoginViewModelProtocol {
        return LoginViewModel(worker: authWorker())
    }
    
    func registerViewModel() -> RegisterViewModelProtocol {
        return RegisterViewModel(worker: authWorker())
    }
    
    func otpViewModel(userName: String) -> OtpViewModelProtocol {
        return OtpViewModel(userName: userName)
    }
    
}
