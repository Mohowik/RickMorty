//
//  MainStorable.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 08.06.2023.
//

import Foundation
import RealmSwift
import RxSwift

protocol MainStorable {
    var storageEventObservable: Observable<RealmStorageEvents> { get }
    
    func loadItems(_ type: ScreenType, _ page: Int)
    
    func getLikedItems(_ type: ScreenType) -> [BaseItemable]
    
    func setOrRemoveLike(_ type: ScreenType, _ id: Int, _ isLiked: Bool)
}

final class StorageManager: MainStorable {
    
    private let service: IMainServiceMVVM
    
    private let realm = try! Realm()
    private let storageEventSubject = PublishSubject<RealmStorageEvents>()

    var storageEventObservable: Observable<RealmStorageEvents> { storageEventSubject.asObserver() }
    
    init(service: IMainServiceMVVM) {
        self.service = service
    }
    
    // MARK: - Load items
    
    func loadItems(_ type: ScreenType, _ page: Int) {
        switch type {
        case .charactersScreen:
            loadCharacters(page)
        case .episodesScreen:
            loadEpisodes(page)
        case .locationScreen:
            loadLocations(page)
        }
    }
    
    private func loadCharacters(_ page: Int) {
        service.getCharacters(page: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.saveCharactersItems(response)
            case .failure:
                break
            }
        }
    }
    
    private func loadEpisodes(_ page: Int) {
        service.getEpisodes(page: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.saveEpisodesItems(response)
            case .failure:
                break
            }
        }
    }
    
    private func loadLocations(_ page: Int) {
        service.getLocations(page: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.saveLocationsItems(response)
            case .failure:
                break
            }
        }
    }
    
    // MARK: - Save items
    
    private func saveCharactersItems(_ items: CharactersResponse) {
        try! realm.write {
            let list = List<CharactersListItem>()
            list.append(objectsIn: items.results.map { CharactersListItem(response: $0) })
            
            if let object = realm.objects(CharactersPersistence.self).first,
               !list.map({$0.id}).allSatisfy(object.results.map({$0.id}).contains) {
                object.results.append(objectsIn: list)
            } else if realm.objects(CharactersPersistence.self).first == nil {
                let obj = CharactersPersistence(pages: items.info.pages, results: list)
                realm.add(obj)
            }
        }
        storageEventSubject.onNext(.itemsSet(.charactersScreen, getItems(.charactersScreen), items.info.pages))
    }

    private func saveEpisodesItems(_ items: EpisodesResponse) {
        try! realm.write {
            let list = List<EpisodesListItem>()
            list.append(objectsIn: items.results.map { EpisodesListItem(response: $0) })
            
            if let object = realm.objects(EpisodesPersistence.self).first, !list.map({$0.id}).allSatisfy(object.results.map({$0.id}).contains) {
                object.results.append(objectsIn: list)
            } else if realm.objects(EpisodesPersistence.self).first == nil {
                let obj = EpisodesPersistence(pages: items.info.pages, results: list)
                realm.add(obj)
            }
        }
        storageEventSubject.onNext(.itemsSet(.episodesScreen, getItems(.episodesScreen), items.info.pages))
    }
    
    private func saveLocationsItems(_ items: LocationResponse) {
        try! realm.write {
            let list = List<LocationsListItem>()
            list.append(objectsIn: items.results.map { LocationsListItem(response: $0) })
            
            if let object = realm.objects(LocationsPersistence.self).first, !list.map({$0.id}).allSatisfy(object.results.map({$0.id}).contains) {
                object.results.append(objectsIn: list)
            } else if realm.objects(LocationsPersistence.self).first == nil {
                let obj = LocationsPersistence(pages: items.info.pages, results: list)
                realm.add(obj)
            }
        }
        storageEventSubject.onNext(.itemsSet(.locationScreen, getItems(.locationScreen), items.info.pages))
    }
    
    // MARK: - Get items
    
    private func getItems(_ type: ScreenType) -> [BaseItemable] {
        switch type {
        case .charactersScreen:
            return Array(realm.objects(CharactersListItem.self))
        case .episodesScreen:
            return Array(realm.objects(EpisodesListItem.self))
        case .locationScreen:
            return Array(realm.objects(LocationsListItem.self))
        }
    }
    
    // MARK: - Get liked items
    
    func getLikedItems(_ type: ScreenType) -> [BaseItemable] {
        switch type {
        case .charactersScreen:
            return Array(realm.objects(CharactersListItem.self).where { $0.isLiked })
        case .episodesScreen:
            return Array(realm.objects(EpisodesListItem.self).where { $0.isLiked })
        case .locationScreen:
            return Array(realm.objects(LocationsListItem.self).where { $0.isLiked })
        }
    }
    
    // MARK: - Set or Remove like on item
    
    func setOrRemoveLike(_ type: ScreenType, _ id: Int, _ isLiked: Bool)  {
        switch type {
        case .charactersScreen:
            setOrRemoveLikeCharacter(id, isLiked)
        case .episodesScreen:
            setOrRemoveLikeEpisode(id, isLiked)
        case .locationScreen:
            setOrRemoveLikeLocation(id, isLiked)
        }
    }
    
    private func setOrRemoveLikeCharacter(_ id: Int, _ isLiked: Bool) {
        guard let object = realm.objects(CharactersListItem.self).where({ $0.id == id }).first else { return }
        try! realm.write { [weak self] in
            object.isLiked = isLiked
            self?.storageEventSubject.onNext((.itemLiked(.charactersScreen)))
        }
    }
    
    private func setOrRemoveLikeEpisode(_ id: Int, _ isLiked: Bool) {
        guard let object = realm.objects(EpisodesListItem.self).where({ $0.id == id }).first else { return }
        try! realm.write { [weak self] in
            object.isLiked = isLiked
            self?.storageEventSubject.onNext((.itemLiked(.episodesScreen)))
        }
    }
    
    private func setOrRemoveLikeLocation(_ id: Int, _ isLiked: Bool) {
        guard let object = realm.objects(LocationsListItem.self).where({ $0.id == id }).first else { return }
        try! realm.write { [weak self] in
            object.isLiked = isLiked
            self?.storageEventSubject.onNext((.itemLiked(.locationScreen)))
        }
    }
}

enum RealmStorageEvents {
    case itemLiked(ScreenType)
    case itemsSet(ScreenType, [BaseItemable], Int)
}


