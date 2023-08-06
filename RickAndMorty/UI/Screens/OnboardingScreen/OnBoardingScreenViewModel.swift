//
//  OnBoardingScreenViewModel.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 18.07.2023.
//

import RxSwift

struct OnBoardingScreenViewModelActions {
    let openMainFlow: VoidClosure?
}

protocol OnBoardingScreenViewModelInput {
    func openMainFlow()
}

protocol OnBoardingScreenViewModelOutput {}

protocol OnBoardingScreenViewModel: OnBoardingScreenViewModelInput, OnBoardingScreenViewModelOutput {}

final class DefaultOnBoardingScreenViewModel: OnBoardingScreenViewModel {

    private let actions: OnBoardingScreenViewModelActions?
    
// MARK: - Init
    
    init(actions: OnBoardingScreenViewModelActions? = nil) {
        self.actions = actions
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - INPUT. View event methods
extension DefaultOnBoardingScreenViewModel {
    
    func openMainFlow() {
        actions?.openMainFlow?()
    }
}
