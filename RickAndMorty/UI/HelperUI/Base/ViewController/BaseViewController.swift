//
//  BaseViewController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private(set) lazy var navigationBar: NavigationBar = {
        let view = NavigationBar()
        return view
    }()

    lazy var backActionClosure: () -> Void = { [weak self] in self?.navigationController?.popViewController(animated: true) }
    
    override func loadView() {
        super.loadView()
        view.addTapGestureToHideKeyboard()
        view.backgroundColor = BaseColor.hex_F1F6ED
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func hideNavBar() {
        navigationBar.isHidden = true
        self.additionalSafeAreaInsets.top = 0
    }
    
    private func setNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        if (self != navigationController?.viewControllers[0] ) {
            let button = UIButton()
            let image = AppIcons.getIcon(.i_back_arrow)
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            button.snp.makeConstraints { (make) in
                make.width.height.equalTo(24)
            }
            navigationBar.addItem(button, toPosition: .leftSide)
        }
        additionalSafeAreaInsets.top = 50
    }
    
    @objc private func backAction() {
        backActionClosure()
    }
}
