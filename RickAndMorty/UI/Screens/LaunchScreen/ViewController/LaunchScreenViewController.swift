//
//  LaunchScreenViewController.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Combine
import Foundation

final class LaunchScreenViewController<View: LaunchScreenView>: BaseViewController<View> {
    
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
        navBar.hideView()
        preparationFinished?()
    }
}
