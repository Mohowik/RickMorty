//
//  LocarionsListScreenViewModel.swift
//  RickMorty
//
//  Created by Roman Mokh on 18.07.2023.
//

import RxSwift

struct LocationsListScreenViewModelActions {
    var openDetail: ItemClosure?
}

protocol LocationsListScreenViewModelInput{
    func viewDidLoad(page: Int)
    func openDetail(model: BaseItemable)
    func setLikeOrDislike(id: Int, isLiked: Bool)
}

protocol LocationsListScreenViewModelOutput {
    var onLocationsListLoadedObservable: Observable<([BaseItemable], Int)> { get }
    var onLocationsListReloadedObservable: Observable<Void> { get }
}

protocol LocationsListScreenViewModel: LocationsListScreenViewModelInput, LocationsListScreenViewModelOutput{}

final class DefaultLocationsListScreenViewModel: LocationsListScreenViewModel {
    private let actions: LocationsListScreenViewModelActions?
    private let storage: MainStorable
    
    private let onLocationsListLoadedSubject = PublishSubject<([BaseItemable], Int)>()
    private let onLocationsListReloadedSubject = PublishSubject<Void>()

    private let disposeBag = DisposeBag()
    
    // MARK: - OUTPUT
    
    var onLocationsListLoadedObservable: Observable<([BaseItemable], Int)> { onLocationsListLoadedSubject.asObserver() }
    var onLocationsListReloadedObservable: Observable<Void> { onLocationsListReloadedSubject.asObserver() }
    
    // MARK: - Init
    
    init (actions: LocationsListScreenViewModelActions, storage: MainStorable) {
        self.actions = actions
        self.storage = storage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func load(page: Int) {
        storage.loadItems(.locationScreen, page)
    }
    
    private func subscribeOnStorage() {
        storage.storageEventObservable.subscribe(onNext: { [weak self] event in
            guard let self = self else { return }
            self.onStorageEvents(event)
        }).disposed(by: disposeBag)
    }
    
    private func onStorageEvents(_ event: RealmStorageEvents) {
        switch event {
        case .itemsSet(let type, let items, let countOfPages):
            if type == .locationScreen {
                onLocationsListLoadedSubject.onNext((items, countOfPages))
            }
        case .itemLiked(let type):
            if type == .locationScreen {
                onLocationsListReloadedSubject.onNext(())
            }
        }
    }
}

// MARK: - INPUT. View event methods

extension DefaultLocationsListScreenViewModel {
    
    func viewDidLoad(page: Int) {
        load(page: page)
        subscribeOnStorage()
    }
    
    func openDetail(model: BaseItemable) {
        actions?.openDetail?(model)
    }
    
    func setLikeOrDislike(id: Int, isLiked: Bool) {
        storage.setOrRemoveLike(.locationScreen, id, isLiked)
    }
}
