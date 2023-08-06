//
//  FavoritesListScreenViewModel.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 20.07.2023.
//

import RxSwift

struct FavoritesListScreenViewModelActions {
    let openDetailScreen: ((BaseItemable, ScreenType) -> Void)?
}

protocol FavoritesListScreenViewModelInput{
    func removeLike(id: Int)
    func setScreenType(selectedIndex: Int)
    func startSearch(searchText: String)
    func openItemDetail(model: BaseItemable)
}

protocol FavoritesListScreenViewModelOutput{
    var screenType: ScreenType { get }

    var onFavoritesListLoadedObservable: Observable<[BaseItemable]> { get }
    var onFavoritesListSearchedObservable: Observable<[BaseItemable]> { get }
    var onFavoritesListEmptyObservable: Observable<Void> { get }
}
protocol FavoritesListScreenViewModel: FavoritesListScreenViewModelInput, FavoritesListScreenViewModelOutput{}

final class DefaultFavoritesListScreenViewModel: FavoritesListScreenViewModel {
    
    private let actions: FavoritesListScreenViewModelActions?
    private let storage: MainStorable

    private var items: [BaseItemable] { storage.getLikedItems(screenType) }
    
    private let onFavoritesListLoadedSubject = PublishSubject<[BaseItemable]>()
    private let onFavoritesListSearchedSubject = PublishSubject<[BaseItemable]>()
    private let onFavoritesListEmptySubject = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
        
    // MARK: - OUTPUT
    
    var screenType: ScreenType = .charactersScreen

    var onFavoritesListLoadedObservable: Observable<[BaseItemable]> { onFavoritesListLoadedSubject.asObserver() }
    var onFavoritesListSearchedObservable: Observable<[BaseItemable]> { onFavoritesListSearchedSubject.asObserver() }
    var onFavoritesListEmptyObservable: Observable<Void> { onFavoritesListEmptySubject.asObserver() }
    
    // MARK: - Init
    init(storage: MainStorable, actions: FavoritesListScreenViewModelActions) {
        self.storage = storage
        self.actions = actions
        subscribeOnStorage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func subscribeOnStorage() {
        storage.storageEventObservable.subscribe(onNext: { [weak self] events in
            guard let self = self else { return }
            self.onStorageEvents(events)
        }).disposed(by: disposeBag)
    }
    
    private func onStorageEvents(_ event: RealmStorageEvents) {
        switch event {
        case .itemLiked:
            onFavoritesListLoadedSubject.onNext((items))
        default:
            break
        }
    }
}

// MARK: - INPUT. View event methods
extension DefaultFavoritesListScreenViewModel {

    func openItemDetail(model: BaseItemable) {
        actions?.openDetailScreen?(model, screenType)
    }
    
    func setScreenType(selectedIndex: Int) {
        guard let type = ScreenType(rawValue: selectedIndex) else { return }
        screenType = type
        onFavoritesListLoadedSubject.onNext((items))
    }
    
    func startSearch(searchText: String) {
        guard !searchText.isEmpty else {
            onFavoritesListLoadedSubject.onNext((items))
            return
        }
        let searchedItems = items.filter { $0.name.contains(searchText)}
        if searchedItems.isEmpty {
            onFavoritesListEmptySubject.onNext(())
        } else {
            onFavoritesListSearchedSubject.onNext((searchedItems))
        }
    }
    
    func removeLike(id: Int) {
        storage.setOrRemoveLike(screenType, id, false)
    }
}
