//
//  CharactersList.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 08.06.2023.
//

import RealmSwift

final class CharactersListItem: Object, BaseItemable {
    @Persisted(primaryKey: true) var primaryId: ObjectId
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var status: String
    @Persisted var species: String
    @Persisted var type: String
    @Persisted var gender: String
    @Persisted var image: String
    @Persisted var url: String
    @Persisted var created: String
    @Persisted var isAlive: Bool
    @Persisted var isLiked: Bool = false
    
    convenience init(response: Characters) {
        self.init()
        self.primaryId = .generate()
        self.id = response.id
        self.name = response.name
        self.status = response.status
        self.species = response.species
        self.type = response.type
        self.gender = response.gender
        self.image = response.image
        self.url = response.url
        self.created = response.created
        self.isAlive = response.isAlive
        self.isLiked = response.isLiked
    }
}
