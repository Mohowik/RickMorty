//
//  LocationsCoordinator.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import Foundation

final class LocationsCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showLocationsListScreen()
    }
    
    private func showLocationsListScreen() {
        let actions = LocationsListScreenViewModelActions { [weak self] location in self?.showDetailScreen(item: location, type: .locationScreen)
        }
        let screen = screenFactory.makeLocationsListViewController(actions: actions)
        router.setRootModule(screen, hideBar: true)
    }

    private func showDetailScreen(item: BaseItemable, type: ScreenType) {
        let screen = screenFactory.makeDetailScreenController(item: item, screenType: type)
        router.push(screen, hideBottomBar: true)
    }
    
}
