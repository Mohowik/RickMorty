//
//  StartCoordinator.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import Foundation

final class StartCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showSplash()
    }
    
    private func showSplash() {
        let actions = LaunchScreeenViewModelActions(preparationFinished: showOnBoardingScreen)
        let viewController = screenFactory.makeLaunchScreenViewController(actions: actions)
        router.setRootModule(viewController, hideBar: true)
    }
    
    private func showOnBoardingScreen() {
        let actions = OnBoardingScreenViewModelActions(openMainFlow: finishFlow)
        let screen = screenFactory.makeOnBoardingScreenController(actions: actions)
        router.setRootModule(screen, hideBar: true)
    }
}
