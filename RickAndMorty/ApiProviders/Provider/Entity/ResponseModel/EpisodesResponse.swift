//
//  EpisodesResponse.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 20.05.2023.
//

import RealmSwift

struct EpisodesResponse: Decodable {
    let info: EpisodesInfo
    let results: [Episodes]
}

struct EpisodesInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Episodes: Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let url: String
    let created: String
    let isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case url
        case created
    }
}

final class EpisodesPersistence: Object {
    @Persisted(primaryKey: true) var primaryId: ObjectId
    @Persisted var pages: Int
    @Persisted var results: List<EpisodesListItem>
    
    convenience init(pages: Int, results: List<EpisodesListItem>) {
        self.init()
        self.primaryId = .generate()
        self.pages = pages
        self.results = results
    }
}
