//
//  RequestBuilderImpl.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation

protocol RequestBuilderProtocol {
    
    func requestBuild(path: String, urlParametrs: [String: String?]) -> URLRequest?
        
    func postBuild(path: String, urlParametrs: [String: String]) -> URLRequest?
    
    func requestBuildMyIp(urlParametrs: [String: String?]) -> URLRequest?
}

class RequestBuilder: RequestBuilderProtocol {
    
    private let configuration: ConfigurationProtocol
    
    private var scheme: String { configuration.scheme }
    private var host: String { configuration.host }
    
    init(configuration: ConfigurationProtocol) {
        self.configuration = configuration
    }
    
    func requestBuild(path: String, urlParametrs: [String: String?]) -> URLRequest? {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = path
        urlConstructor.queryItems = urlParametrs.map({ name, value -> URLQueryItem in
            return URLQueryItem(name: name, value: value)
        })
        guard let url = urlConstructor.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    func postBuild(path: String, urlParametrs: [String: String]) -> URLRequest? {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = path
        
        guard let url = urlConstructor.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let jsonString = urlParametrs.reduce("") { "\($0)\($1.0)=\($1.1)&" }.dropLast()
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        request.httpBody = jsonData
        
        return request
    }

    func requestBuildMyIp(urlParametrs: [String: String?]) -> URLRequest? {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.ipify.org"
        urlConstructor.path = ""
        urlConstructor.queryItems = urlParametrs.map({ name, value -> URLQueryItem in
            return URLQueryItem(name: name, value: value)
        })
        
        guard let url = urlConstructor.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
}
