//
//  ConfigurationProtocol.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2022.
//

import Foundation

protocol IConfigurationMVVM {
    var scheme: String { get }
    var host: String { get }
}

extension IConfigurationMVVM {
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

struct ConfigurationMVVM: IConfigurationMVVM {
    static let shared: IConfigurationMVVM = ConfigurationMVVMProd()
    
    let scheme: String = ConfigurationMVVM.shared.scheme
    let host: String = ConfigurationMVVM.shared.host
}

struct ConfigurationMVVMProd: IConfigurationMVVM {
    let scheme: String = "https"
    let host = "rickandmortyapi.com/api"
}
