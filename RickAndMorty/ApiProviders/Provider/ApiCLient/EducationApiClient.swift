//
//  EducationApiClient.swift
//  Education
//
//  Created by iMac on 18.10.2022.
//


import Foundation
import Combine

protocol EducationApiClientProtocol {
    
}

private func getPath(for method: String) -> String {
    return "/api/\(method)"
}

extension ApiClient: EducationApiClientProtocol {

}

