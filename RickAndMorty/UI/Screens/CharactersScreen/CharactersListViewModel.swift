//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import RxSwift

struct CharactersListViewModelActions {
    var openDetail: ItemClosure?
}

protocol CharactersListViewModelInput {
    func viewDidLoad(page: Int)
    func openDetail(model: BaseItemable)
    func setLikeOrDislike(id: Int, isLiked: Bool)
}
    
protocol CharactersListViewModelOutput {
    var onCharactersListLoadedObservable: Observable<([BaseItemable], Int)> { get }
    var onCharactersListReloadedObservable: Observable<Void> { get }
}

protocol CharactersListViewModel: CharactersListViewModelInput, CharactersListViewModelOutput {}

final class DefaultCharactersListViewModel: CharactersListViewModel {
    private let actions: CharactersListViewModelActions?
    private let storage: MainStorable
    
    private let onCharactersListLoadedSubject = PublishSubject<([BaseItemable], Int)>()
    private let onCharactersListReloadedSubject = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - OUTPUT
    
    var onCharactersListLoadedObservable: Observable<([BaseItemable], Int)> { onCharactersListLoadedSubject.asObserver() }
    var onCharactersListReloadedObservable: Observable<Void> { onCharactersListReloadedSubject.asObserver() }
    
    // MARK: - Init
    
    init(actions: CharactersListViewModelActions, storage: MainStorable) {
        self.actions = actions
        self.storage = storage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func load(page: Int) {
        storage.loadItems(.charactersScreen, page)
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
            if type == .charactersScreen {
                onCharactersListLoadedSubject.onNext((items, countOfPages))
            }
        case .itemLiked(let type):
            if type == .charactersScreen {
                onCharactersListReloadedSubject.onNext(())
            }
        }
    }
}

// MARK: - INPUT. View event methods

extension DefaultCharactersListViewModel {
    
    func viewDidLoad(page: Int) {
        load(page: page)
        subscribeOnStorage()
    }
    
    func openDetail(model: BaseItemable) {
        actions?.openDetail?(model)
    }
    
    func setLikeOrDislike(id: Int, isLiked: Bool) {
        storage.setOrRemoveLike(.charactersScreen, id, isLiked)
    }

}
