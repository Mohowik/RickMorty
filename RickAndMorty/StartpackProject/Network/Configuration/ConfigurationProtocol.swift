//
//  ConfigurationProtocol.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation

protocol ConfigurationProtocol {
    var scheme: String { get }
    var host: String { get }
}

extension ConfigurationProtocol {
    var baseUrl: String {
        return "\(scheme)://\(host)"
    }
    
    func buildUrl(for path: String) -> String {
        guard !path.isEmpty else {
            return path
        }
        return baseUrl + path
    }
}

struct Configuration: ConfigurationProtocol {
    static let shared: ConfigurationProtocol = ConfigurationProd()
    
    let scheme: String = Configuration.shared.scheme
    let host: String = Configuration.shared.host
}

struct ConfigurationTest: ConfigurationProtocol {
    let scheme: String = "http"
    let host = "ovz4.j04713753.pv29m.vps.myjino.ru"
}

struct ConfigurationProd: ConfigurationProtocol {
    let scheme: String = "https"
    let host = "rickandmortyapi.com"
}
