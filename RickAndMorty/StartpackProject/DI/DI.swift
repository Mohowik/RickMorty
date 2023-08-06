//
//  DI.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

final class Di {
    
    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactoryProtocol
    fileprivate let storage: MainStorable
    
    private let networkClient: INetworkClientMVVM
    private let mainService: IMainServiceMVVM
    
    init() {
        
        screenFactory = ScreenFactory()
        coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
        
        networkClient = NetworkClientMVVM()
        mainService = MainServiceMVVM(networkClient)
                
        storage = StorageManager(service: mainService)
        
        screenFactory.di = self
    }
}

protocol AppFactoryProtocol {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension Di: AppFactoryProtocol {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        let router = Router(rootController: rootVC)
        let coordinator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, coordinator)
    }
}

protocol ScreenFactoryProtocol {
        
    func makeLaunchScreenViewController(actions: LaunchScreeenViewModelActions) -> LaunchScreenViewController
    
    func makeOnBoardingScreenController(actions: OnBoardingScreenViewModelActions) -> OnboardingScreenViewController
    
    func makeCharactersListViewController(actions: CharactersListViewModelActions) -> CharactersListViewController
    
    func makeEpisodesListViewController(actions: EpisodesListViewModelActions) -> EpisodesListViewController
    
    func makeLocationsListViewController(actions: LocationsListScreenViewModelActions) -> LocationsListScreenViewController
    
    func makeFavoritesListScreenViewController(actions: FavoritesListScreenViewModelActions) -> FavoritesListScreenViewController
    
    func makeDetailScreenController(item: BaseItemable, screenType: ScreenType) -> DetailScreenController
}

final class ScreenFactory: ScreenFactoryProtocol {
    
    fileprivate weak var di: Di!
    fileprivate init() {}
    
    func makeLaunchScreenViewController(actions: LaunchScreeenViewModelActions) -> LaunchScreenViewController {
        return LaunchScreenViewController.create(with: makeLaunchScreeenViewModel(actions: actions))
    }
    
    func makeLaunchScreeenViewModel(actions: LaunchScreeenViewModelActions) -> LaunchScreeenViewModel {
        return DefaultLaunchScreeenViewModel(actions: actions)
    }
    
    func makeOnBoardingScreenController(actions: OnBoardingScreenViewModelActions) -> OnboardingScreenViewController {
        return OnboardingScreenViewController.create(with: makeOnBoardingScreenViewModel(actions: actions))
    }
    
    func makeOnBoardingScreenViewModel(actions: OnBoardingScreenViewModelActions) -> OnBoardingScreenViewModel {
        return DefaultOnBoardingScreenViewModel(actions: actions)
    }
    
    func makeCharactersListViewController(actions: CharactersListViewModelActions) -> CharactersListViewController {
        return CharactersListViewController.create(with: makeCharactersListViewModel(actions: actions))
    }
    
    func makeCharactersListViewModel(actions: CharactersListViewModelActions) -> CharactersListViewModel {
        return DefaultCharactersListViewModel(actions: actions, storage: di.storage)
    }
    
    func makeEpisodesListViewController(actions: EpisodesListViewModelActions) -> EpisodesListViewController {
        return EpisodesListViewController.create(with: makeEpisodesListViewModel(actions: actions))
    }
    
    func makeEpisodesListViewModel(actions: EpisodesListViewModelActions) -> EpisodesListViewModel {
        return DefaultEpisodesListViewModel(actions: actions, storage: di.storage)
    }

    func makeLocationsListViewController(actions: LocationsListScreenViewModelActions) -> LocationsListScreenViewController {
        return LocationsListScreenViewController.create(with: makeLocationsListViewModel(actions: actions))
    }
    
    func makeLocationsListViewModel(actions: LocationsListScreenViewModelActions) -> LocationsListScreenViewModel {
        return DefaultLocationsListScreenViewModel(actions: actions, storage: di.storage)
    }
    
    func makeDetailScreenController(item: BaseItemable,
                                    screenType: ScreenType) -> DetailScreenController {
        return DetailScreenController.create(with: makeDetailScreenViewModel(item: item,
                                                                             screenType: screenType))
    }
    
    func makeDetailScreenViewModel(item: BaseItemable,
                                   screenType: ScreenType) -> DetailScreenViewModel {
        return DefaultDetailScreenViewModel(item: item,
                                            screenType: screenType,
                                            storage: di.storage)
    }
    
    func makeFavoritesListScreenViewController(actions: FavoritesListScreenViewModelActions) -> FavoritesListScreenViewController {
        return FavoritesListScreenViewController.create(with: makeFavoritesListScreenViewModel(actions: actions))
    }
    
    func makeFavoritesListScreenViewModel( actions: FavoritesListScreenViewModelActions) -> FavoritesListScreenViewModel {
        return DefaultFavoritesListScreenViewModel(storage: di.storage, actions: actions)
    }
}

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator
    func makeStartCoordinator(router: RouterProtocol) -> StartCoordinator
    func makeTabCoordinator(router: RouterProtocol) -> TabCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    private let screenFactory: ScreenFactoryProtocol
    
    fileprivate init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeStartCoordinator(router: RouterProtocol) -> StartCoordinator {
        StartCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeTabCoordinator(router: RouterProtocol) -> TabCoordinator {
        let tabBarController = TabBarCustomController(screenFactory: screenFactory)
        return TabCoordinator(tabBarController: tabBarController, router: router, screenFactory: screenFactory)
    }
}
