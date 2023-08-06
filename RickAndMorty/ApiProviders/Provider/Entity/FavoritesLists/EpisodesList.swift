//
//  EpisodesList.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 16.06.2023.
//

import Foundation
import RealmSwift

final class EpisodesListItem: Object, BaseItemable {
    @Persisted(primaryKey: true) var primaryId: ObjectId
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var airDate: String
    @Persisted var episode: String
    @Persisted var url: String
    @Persisted var created: String
    @Persisted var isLiked: Bool = false
    
    func checkSeason() -> UIImage {
        let numberOfSeason = String(episode [episode.index(episode.startIndex, offsetBy: 2)])
        switch numberOfSeason {
        case "1":
            return AppIcons.getIcon(.i_s1)
        case "2":
            return AppIcons.getIcon(.i_s2)
        case "3":
            return AppIcons.getIcon(.i_s3)
        case "4":
            return AppIcons.getIcon(.i_s4)
        case "5":
            return AppIcons.getIcon(.i_s5)
        default:
            return UIImage()
        }
    }
    
    convenience init(response: Episodes) {
        self.init()
        self.primaryId = .generate()
        self.id = response.id
        self.name = response.name
        self.airDate = response.airDate
        self.episode = response.episode
        self.url = response.url
        self.created = response.created
        self.isLiked = response.isLiked
    }
}
