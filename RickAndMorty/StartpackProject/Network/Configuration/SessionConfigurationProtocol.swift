//
//  SessionConfigurationProtocol.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation

protocol SessionConfigurationProtocol {
    var configuration: URLSessionConfiguration { get }
}

struct SessionConfiguration: SessionConfigurationProtocol {
    
    var configuration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 30 // Ожидание запроса в секндах
        config.timeoutIntervalForRequest = 60
        config.waitsForConnectivity = true // Флаг стоит ли ожидать появление сети время зависит от timeoutIntervalForResource
        return config
    }
}
