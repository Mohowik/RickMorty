//
//  CharactersCoordinator.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import Foundation

final class CharactersCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showCharactersListScreen()
    }
    
    private func showCharactersListScreen() {
        let actions = CharactersListViewModelActions { [weak self] character in
            self?.showDetailScreen(item: character, type: .charactersScreen)
        }
        let screen = screenFactory.makeCharactersListViewController(actions: actions)
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showDetailScreen(item: BaseItemable, type: ScreenType) {
        let screen = screenFactory.makeDetailScreenController(item: item,
                                                              screenType: type)
        router.push(screen, hideBottomBar: true)
    }
}
