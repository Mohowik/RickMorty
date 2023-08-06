//
//  SaveItemsCoordinator.swift
//  Education
//
//  Created by iMac on 02.11.2022.
//

import Foundation

final class SaveItemsCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showSaveItemsScreen()
    }
    
    private func showSaveItemsScreen() {
        let screen = screenFactory.makeSaveItemsScreen()
        router.setRootModule(screen, hideBar: true)
    }
}
