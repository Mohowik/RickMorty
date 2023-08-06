//
//  ProviderMVVM.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import Foundation
import RxSwift
import Moya

enum MainProviderMVVM {
    case getCharacters(page: Int)
    case getEpisodes(page: Int)
    case getLocations(page: Int)
}

extension MainProviderMVVM: TargetType {
    var baseURL: URL {
        URL(string: ConfigurationMVVM.shared.baseUrl)!
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        case .getEpisodes:
            return "/episode"
        case .getLocations:
            return "/location"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCharacters:
            return .get
        case .getEpisodes:
            return .get
        case .getLocations:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getCharacters(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .getEpisodes(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .getLocations(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? { [:] }
}
