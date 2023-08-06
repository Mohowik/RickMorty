//
//  EpisodesCoordinator.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import Foundation

final class EpisodesCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showEpisodesListScreen()
    }
    
    private func showEpisodesListScreen() {
        let actions = EpisodesListViewModelActions { [weak self] episode in
            self?.showDetailScreen(episode: episode, type: .episodesScreen)}
        let screen = screenFactory.makeEpisodesListViewController(actions: actions)
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showDetailScreen(episode: BaseItemable, type: ScreenType) {
        let screen = screenFactory.makeDetailScreenController(item: episode, screenType: type)
        router.push(screen, hideBottomBar: true)
    }

}
