//
//  ServiceMVVM.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 16.07.2023.
//

import Foundation
import Moya

protocol IMainServiceMVVM {
    func getCharacters(page: Int, completion: @escaping NetworkingParameterClosure<Result<CharactersResponse, NetworkingError>>)
    func getEpisodes(page: Int, completion: @escaping NetworkingParameterClosure<Result<EpisodesResponse, NetworkingError>>)
    func getLocations(page: Int, completion: @escaping NetworkingParameterClosure<Result<LocationResponse, NetworkingError>>)
}

final class MainServiceMVVM: IMainServiceMVVM {
    
    private let networkClient: INetworkClientMVVM
    
    init(_ networkClient: INetworkClientMVVM) {
        self.networkClient = networkClient
    }
    
    func getCharacters(page: Int, completion: @escaping NetworkingParameterClosure<Result<CharactersResponse, NetworkingError>>) {
        let target = MultiTarget(MainProviderMVVM.getCharacters(page: page))
        networkClient.performRequest(target: target, successClosure: { response in
            do {
                let items = try JSONDecoder().decode(CharactersResponse.self, from: response.data)
                completion(.success(items))
            } catch {
                completion(.failure(.stringError(error.localizedDescription)))
            }
        }, progressClosure: nil, failureClosure: { errorString in
            completion(.failure(.stringError(errorString)))
        })
    }
    
    func getEpisodes(page: Int, completion: @escaping NetworkingParameterClosure<Result<EpisodesResponse, NetworkingError>>) {
        let target = MultiTarget(MainProviderMVVM.getEpisodes(page: page))
        networkClient.performRequest(target: target, successClosure: { response in
            do {
                let items = try JSONDecoder().decode(EpisodesResponse.self, from: response.data)
                completion(.success(items))
            } catch {
                completion(.failure(.stringError(error.localizedDescription)))
            }
        }, progressClosure: nil, failureClosure: { errorString in
            completion(.failure(.stringError(errorString)))
        })
    }
    
    func getLocations(page: Int, completion: @escaping NetworkingParameterClosure<Result<LocationResponse, NetworkingError>>) {
        let target = MultiTarget(MainProviderMVVM.getLocations(page: page))
        networkClient.performRequest(target: target, successClosure: { response in
            do {
                let items = try JSONDecoder().decode(LocationResponse.self, from: response.data)
                completion(.success(items))
            } catch {
                completion(.failure(.stringError(error.localizedDescription)))
            }
        }, progressClosure: nil, failureClosure: { errorString in
            completion(.failure(.stringError(errorString)))
        })
    }
}
