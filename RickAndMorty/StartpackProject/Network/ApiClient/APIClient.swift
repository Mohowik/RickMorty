//
//  APIClient.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation
import Combine

class ApiClient {
    
    let requestBuilder: RequestBuilderProtocol
    
    private let configuration: URLSessionConfiguration
    private let session: URLSession
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    init(requestBuilder: RequestBuilderProtocol, configuration: URLSessionConfiguration) {
        
        self.requestBuilder = requestBuilder
        self.configuration = configuration
    
        self.session = URLSession(configuration: configuration)
    }
    
    func performRequest<T: Decodable>(_ request: URLRequest?) -> AnyPublisher<T, Error> {
        guard  let request = request else {
            return Future<T, Error> { $0(.failure(ApiError.requestIncorrect)) }.eraseToAnyPublisher()
        }
//        print(configuration.httpCookieStorage?.cookies)
        
        return URLSession.DataTaskPublisher(request: request, session: session)
            .tryMap { (data, response) in
//                print(request)
                let responseData = String(data: data, encoding: String.Encoding.utf8)
//                print(responseData)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ApiError.unknown
                }
                if 405..<500 ~= httpResponse.statusCode {
                    throw ApiError.apiError(reason: "Ошибка на клиенте! Что-то пошло не так.")
                }
                if 500..<600 ~= httpResponse.statusCode {
                    throw ApiError.apiError(reason: "Ошибка сервера, проверьте соединение с интернетом или попробуйте позже.")
                }
                return data
            }.decode(type: T.self, decoder: decoder)
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                if error is URLError {
                    return ApiError.networkError
                }
                if error is DecodingError {
                    return ApiError.decoding
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
    func loadImageDataMap(_ request: URLRequest?) -> AnyPublisher<Data, Error> {
        guard  let request = request else {
            return Future<Data, Error> { $0(.failure(ApiError.requestIncorrect)) }.eraseToAnyPublisher()
        }
        return URLSession.DataTaskPublisher(request: request, session: session)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ApiError.unknown
                }
                if 405..<500 ~= httpResponse.statusCode {
                    throw ApiError.apiError(reason: "Что-то пошло не так.")
                }
                if 500..<600 ~= httpResponse.statusCode {
                    throw ApiError.apiError(reason: "Ошибка сервера, проверьте соединение с интернетом или попробуйте позже.")
                }
                return data
            }
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                if error is URLError {
                    return ApiError.networkError
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
}
