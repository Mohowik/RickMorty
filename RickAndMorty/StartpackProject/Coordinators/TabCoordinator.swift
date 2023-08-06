//
//  TabCoordinator.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

final class TabCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    private let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController, router: RouterProtocol, screenFactory: ScreenFactoryProtocol ) {
        self.tabBarController = tabBarController
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        //MARK: Characters
        let charactersNavigationController = UINavigationController()
        let charactersBarItem = UITabBarItem(title: titlesTabBarItem.characters.rawValue,
                                        image: AppIcons.getIcon(.i_characters),
                                        selectedImage: AppIcons.getIcon(.i_characters_selected))
        charactersNavigationController.tabBarItem = charactersBarItem
        let charactersRouter = Router(rootController: charactersNavigationController)
        let charactersCoordinator = CharactersCoordinator(router: charactersRouter, screenFactory: screenFactory)
        
        //MARK: Episodes
        let episodesNavigationController = UINavigationController()
        let episodesBarItem = UITabBarItem(title: titlesTabBarItem.episodes.rawValue,
                                       image: AppIcons.getIcon(.i_episodes),
                                       selectedImage: AppIcons.getIcon(.i_episodes_selected))
        episodesNavigationController.tabBarItem = episodesBarItem
        let episodesRouter = Router(rootController: episodesNavigationController)
        let episodesCoordinator = EpisodesCoordinator(router: episodesRouter, screenFactory: screenFactory)
        
        //MARK: Locations
        let locationsNavigationController = UINavigationController()
        let locationsBarItem = UITabBarItem(title: titlesTabBarItem.locations.rawValue,
                                       image: AppIcons.getIcon(.i_locations),
                                       selectedImage: AppIcons.getIcon(.i_locations_selected))
        locationsNavigationController.tabBarItem = locationsBarItem
        let locationsRouter = Router(rootController: locationsNavigationController)
        let locationsCoordinator = LocationsCoordinator(router: locationsRouter, screenFactory: screenFactory)
    
        //MARK: Favorites
        let favoritesNavigationController = UINavigationController()
        let favoritesBarItem = UITabBarItem(title: titlesTabBarItem.favorites.rawValue,
                                       image: AppIcons.getIcon(.i_favorites),
                                       selectedImage: AppIcons.getIcon(.i_favorites_selected))
        favoritesNavigationController.tabBarItem = favoritesBarItem
        let favoritesRouter = Router(rootController: favoritesNavigationController)
        let favoritesCoordinator = FavoritesCoordinator(router: favoritesRouter, screenFactory: screenFactory)
        
        tabBarController.viewControllers = [
            charactersNavigationController,
            episodesNavigationController,
            locationsNavigationController,
            favoritesNavigationController
        ]
        
        router.present(tabBarController, animated: false)
        
        charactersCoordinator.start()
        episodesCoordinator.start()
        locationsCoordinator.start()
        favoritesCoordinator.start()
        
        self.addDependency(charactersCoordinator)
        self.addDependency(episodesCoordinator)
        self.addDependency(locationsCoordinator)
        self.addDependency(favoritesCoordinator)
    }
    
    enum titlesTabBarItem: String {
        case characters = "Characters"
        case episodes = "Episodes"
        case locations = "Locations"
        case favorites = "Favorites"
    }
}
