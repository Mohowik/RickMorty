//
//  ResponseModel.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 19.05.2023.
//

import RealmSwift

struct CharactersResponse: Decodable {
    let info: CharactersInfo
    let results: [Characters]
}

struct CharactersInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Characters: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let created: String
    let isLiked: Bool = false
    
    var isAlive: Bool {
        return status == "Alive"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case image
        case url
        case created
    }

}

struct Origins: Codable {
    let name: String
    let url: String
}

final class CharactersPersistence: Object {
    @Persisted(primaryKey: true) var primaryId: ObjectId
    @Persisted var pages: Int
    @Persisted var results: List<CharactersListItem>
    
    convenience init(pages: Int, results: List<CharactersListItem>) {
        self.init()
        self.primaryId = .generate()
        self.pages = pages
        self.results = results
    }
}

