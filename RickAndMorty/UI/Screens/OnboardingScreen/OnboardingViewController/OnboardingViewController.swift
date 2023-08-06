//
//  OnboardingViewController.swift
//  Education
//
//  Created by iMac on 05.11.2022.
//

import Combine
import Foundation

final class OnboardingViewController<View: OnboardingView>: BaseViewController<View> {
    
    var preparationFinished: VoidClosure?
    var buttonClosure: VoidClosure?
    private var cancalables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
        subscribeForUpdates()
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    private func onViewEvents(_ event: LaunchScreenViewEvent) {
        switch event {
        case .buttonInClicked:
            buttonClosure?()
        }
    }
}
