//
//  EpisodesListViewModel.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 18.07.2023.
//

import RxSwift

struct EpisodesListViewModelActions {
    var openDetail: ItemClosure?
}

protocol EpisodesListViewModelInput{
    func viewDidLoad(page: Int)
    func openDetail(model: BaseItemable)
    func setLikeOrDislike(id: Int, isLiked: Bool)
}

protocol EpisodesListViewModelOutput{
    var onEpisodesListLoadedObservable: Observable<([BaseItemable], Int)> { get }
    var onEpisodesListReloadedObservable: Observable<Void> { get }
}

protocol EpisodesListViewModel: EpisodesListViewModelInput, EpisodesListViewModelOutput{}

final class DefaultEpisodesListViewModel: EpisodesListViewModel {
    private let actions: EpisodesListViewModelActions?
    private let storage: MainStorable
    
    private let onEpisodesListLoadedSubject = PublishSubject<([BaseItemable], Int)>()
    private let onEpisodesListReloadedSubject = PublishSubject<Void>()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - OUTPUT
    
    var onEpisodesListLoadedObservable: Observable<([BaseItemable], Int)> { onEpisodesListLoadedSubject.asObserver() }
    var onEpisodesListReloadedObservable: Observable<Void> { onEpisodesListReloadedSubject.asObserver() }
    
    // MARK: - Init
    
    init (actions: EpisodesListViewModelActions, storage: MainStorable) {
        self.actions = actions
        self.storage = storage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func load(page: Int) {
        storage.loadItems(.episodesScreen, page)
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
            if type == .episodesScreen {
                onEpisodesListLoadedSubject.onNext((items, countOfPages))
            }
        case .itemLiked(let type):
            if type == .episodesScreen {
                onEpisodesListReloadedSubject.onNext(())
            }
        }
    }
}

// MARK: - INPUT. View event methods

extension DefaultEpisodesListViewModel {
   
    func viewDidLoad(page: Int) {
        load(page: page)
        subscribeOnStorage()
    }
    
    func openDetail(model: BaseItemable) {
        actions?.openDetail?(model)
    }
    
    func setLikeOrDislike(id: Int, isLiked: Bool) {
        storage.setOrRemoveLike(.episodesScreen, id, isLiked)
    }
}
