//
//  LocationsList.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 19.06.2023.
//

import Foundation
import RealmSwift

final class LocationsListItem: Object, BaseItemable {
    @Persisted(primaryKey: true) var primaryId: ObjectId
    @Persisted var id: Int
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var dimension: String
    @Persisted var isLiked: Bool = false
    
    convenience init(response: Locations) {
        self.init()
        self.primaryId = .generate()
        self.id = response.id
        self.name = response.name
        self.type = response.type
        self.dimension = response.dimension
        self.isLiked = response.isLiked
    }
}
