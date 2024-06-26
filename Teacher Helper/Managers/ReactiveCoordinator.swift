//
//  ReactiveCoordinator.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 03/12/23.
//

import RxSwift

class ReactiveCoordinator<ResultType>: NSObject {

    public typealias CoordinationResult = ResultType

    public let disposeBag = DisposeBag()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    private func store<T>(coordinator: ReactiveCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func release<T>(coordinator: ReactiveCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }

    @discardableResult
    func coordinate<T>(to coordinator: ReactiveCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.release(coordinator: coordinator) })
    }

    func start(_ di: DependencyContainerProtocol = DependencyContainer.shared) -> Observable<ResultType> {
        fatalError("start() method must be implemented")
    }
}
