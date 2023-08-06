//
//  LocationsScreenViewController.swift
//  Education
//
//  Created by iMac on 02.11.2022.
//
import UIKit
import Combine

final class LocationsViewController<View: LocationsView>: BaseViewController<View> {
    
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
        let title = NavigationBarTitle(title:"Locations")
        navBar.addItem(title, toPosition: .title)
    }
}
