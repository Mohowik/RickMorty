//
//  Itemable.swift
//  RickMorty
//
//  Created by Roman Mokh on 02.08.2023.
//

import UIKit

protocol BaseItemable {
    var id: Int { get }
    var name: String { get }
    var isLiked: Bool { get }
}
