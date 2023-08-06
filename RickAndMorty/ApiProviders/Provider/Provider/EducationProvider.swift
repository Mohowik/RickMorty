//
//  EducationProvider.swift
//  Education
//
//  Created by iMac on 18.10.2022.
//

import Foundation
import Combine

protocol EducationProviderProtocol {

    
    
}

final class EducationProviderImpl: EducationProviderProtocol {

    
    private let educationService: EducationServiceProtocol
    
    
    init(educationService: EducationServiceProtocol) {
        self.educationService = educationService
    }
    
}


