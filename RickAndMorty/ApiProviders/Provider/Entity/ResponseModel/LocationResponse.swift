//
//  LocationsResponse.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 20.05.2023.
//

import RealmSwift

struct LocationResponse: Decodable {
    let info: LocationsInfo
    let results: [Locations]
}

struct LocationsInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Locations: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let isLiked: Bool = false
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case dimension
    }
}

final class LocationsPersistence: Object {
    @Persisted(primaryKey: true) var primaryId: ObjectId
    @Persisted var pages: Int
    @Persisted var results: List<LocationsListItem>
    
    convenience init(pages: Int, results: List<LocationsListItem>) {
        self.init()
        self.primaryId = .generate()
        self.pages = pages
        self.results = results
    }
}
