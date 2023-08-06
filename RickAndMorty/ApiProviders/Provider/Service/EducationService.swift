//
//  EducationService.swift
//  Education
//
//  Created by iMac on 18.10.2022.
//

import Foundation
import Combine

protocol EducationServiceProtocol {
    
}

class EducationService: EducationServiceProtocol {
    
    private let apiClient: EducationApiClientProtocol
    
    init(apiClient: EducationApiClientProtocol) {
        self.apiClient = apiClient
    }
    
}

