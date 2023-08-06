//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appFactory: AppFactoryProtocol = Di()
    private var appCoordinator: Coordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        runUI()
        return true
    }

    private func runUI() {
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator()
        self.window = window
        self.appCoordinator = coordinator
        window.makeKeyAndVisible()
        coordinator.start()
    }

}

