//
//  LaunchScreenViewModel.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 17.07.2023.
//

import Foundation

struct LaunchScreeenViewModelActions {
    let preparationFinished: VoidClosure?
}

protocol LaunchScreeenViewModelInput {
    func preparationFinished()
}

protocol LaunchScreeenViewModelOutput {}

protocol LaunchScreeenViewModel: LaunchScreeenViewModelInput, LaunchScreeenViewModelOutput {}

final class DefaultLaunchScreeenViewModel: LaunchScreeenViewModel {
    
    private let actions: LaunchScreeenViewModelActions?
    
// MARK: - Init
    init(actions: LaunchScreeenViewModelActions? = nil) {
        self.actions = actions
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - INPUT. View event methods
extension DefaultLaunchScreeenViewModel {
    
    func preparationFinished() {
        actions?.preparationFinished?()
    }
}
