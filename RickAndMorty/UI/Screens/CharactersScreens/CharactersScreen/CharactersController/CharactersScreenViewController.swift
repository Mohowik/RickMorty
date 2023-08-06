//
//  MainScreenViewController.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import Combine

final class CharactersScreenViewController<View: CharactersScreenView>: BaseViewController<View> {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        let title = NavigationBarTitle(title:"Characters")
        navBar.addItem(title, toPosition: .title)
    }
}
