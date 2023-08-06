//
//  ApplicationCoordinator.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: RouterProtocol
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runStartFlow()
    }
    
    private func runStartFlow() {
        let coordinator = coordinatorFactory.makeStartCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator]  in
            guard let self = self else { return }
            self.showMainFlow()
            self.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func showMainFlow() {
        let coordinator = coordinatorFactory.makeTabCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self else { return }
            self.start()
            self.removeDependency(coordinator)
        }
        
        self.addDependency(coordinator)
        coordinator.start()
    }
}
