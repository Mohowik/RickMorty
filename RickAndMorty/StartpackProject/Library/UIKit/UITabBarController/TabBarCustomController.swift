//
//  TabBarCustomController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

final class TabBarCustomController: UITabBarController {
    
    let screenFactory: ScreenFactoryProtocol
    
    init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 0
        configureTabBar()
    }
    
    private func configureTabBar() {
        
        let selectedItemTitle: [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.foregroundColor: BaseColor.hex_3BB44A,
             NSAttributedString.Key.font: MainFont.text(size: 12)]
        
        let unselectedItemTitle: [NSAttributedString.Key : Any] =
        [NSAttributedString.Key.foregroundColor: BaseColor.hex_3BB44A.withAlphaComponent(0.5),
             NSAttributedString.Key.font: MainFont.text(size: 12)]
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = BaseColor.hex_FFFFFF
        tabBarAppearance.shadowImage = nil
        tabBarAppearance.shadowColor = nil
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = BaseColor.hex_3BB44A.withAlphaComponent(0.5)
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = BaseColor.hex_3BB44A
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedItemTitle
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = unselectedItemTitle
        
        if #available(iOS 15, *) {
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            tabBar.standardAppearance = tabBarAppearance
        }
        self.modalPresentationStyle = .fullScreen
    }
}

