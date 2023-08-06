//
//  NetworkClientMVVM.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 16.07.2023.
//

import Alamofire
import Foundation
import Moya

enum NetworkingError: Error {
    case stringError(_ error: String)
    case silentError
    case abort
}

protocol INetworkClientMVVM {
    func performRequest(target: MultiTarget,
                        successClosure: MoyaResponseClosure?,
                        progressClosure: Moya.ProgressBlock?,
                        failureClosure: ErrorClosure?)
}

final class NetworkClientMVVM: INetworkClientMVVM {
    private let provider: MoyaProvider<MultiTarget>

    init() {
        var plugins: [PluginType] = []
        #if DEBUG
            // Set for `network_verbose` as `enabled` or `disabled`
            if ProcessInfo.processInfo.environment["network_verbose"] == "enabled" {
                plugins.append(NetworkLoggerPlugin())
            }
        #endif

        provider = MoyaProvider<MultiTarget>(stubClosure: stubClosure, plugins: plugins)
    }

    let stubClosure = { (target: MultiTarget) -> Moya.StubBehavior in
        #if DEBUG
            if ProcessInfo.processInfo.environment["moya_test_stub"] == "enabled" {
                return .delayed(seconds: TimeInterval(0.001))
            }

            guard let stubbed = target.target as? Stubbed,
                  stubbed.isStubbed else { return .never }
            return .immediate
        #else
            return .never
        #endif
    }
    
    func performRequest(target: MultiTarget,
                        successClosure: MoyaResponseClosure?,
                        progressClosure: Moya.ProgressBlock? = nil,
                        failureClosure: ErrorClosure?) {
        DispatchQueue.global(qos: .utility).async {
            self.request(target: target, success: { response in
                successClosure?(response)
            }, progress: { progress in
                DispatchQueue.main.async {
                    progressClosure?(progress)
                }
            }, error: { error in
                DispatchQueue.main.async {
                    failureClosure?(error.localizedDescription)
                }
            }, failure: { moyaError in
                DispatchQueue.main.async {
                    failureClosure?(moyaError.localizedDescription)
                }
            })
        }
    }

@discardableResult
   fileprivate func request(target: MultiTarget,
                 success successCallback: ((Response) -> Void)? = nil,
                 progress progressCallback: Moya.ProgressBlock? = nil,
                 error errorCallback: ((Swift.Error) -> Void)? = nil,
                 failure failureCallback: ((MoyaError) -> Void)? = nil) -> Cancellable {
        return provider.request(target, callbackQueue: DispatchQueue.main, progress: progressCallback) { result in
            switch result {
            case let .success(response):
                if response.statusCode >= 200, response.statusCode <= 300 {
                    successCallback?(response)
                } else if response.statusCode == 304 {
                    let errorText = "304"
                    let error = NSError(domain: "server error",
                                        code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: errorText])
                    DispatchQueue.main.async {
                        errorCallback?(error)
                    }

                } else {
                    let errorText = "Ошибка сервера!\nОбратитесь в поддержку"
                    let error = NSError(domain: "server error",
                                        code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: errorText])
                    DispatchQueue.main.async {
                        errorCallback?(error)
                    }
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    failureCallback?(error)
                }
            }
        }
    }
}
