//
//  FavoritesCoordinator.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import Foundation

final class FavoritesCoordinator: BaseCoordinator {
        
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showFavoritesListScreen()
    }
    
    private func showFavoritesListScreen() {
        let actions = FavoritesListScreenViewModelActions(openDetailScreen: showDetailScreen)
        let screen = screenFactory.makeFavoritesListScreenViewController(actions: actions)
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showDetailScreen(item: BaseItemable, screenType: ScreenType) {
        let screen = screenFactory.makeDetailScreenController(item: item, screenType: screenType)
        router.push(screen, hideBottomBar: true)
    }
}
