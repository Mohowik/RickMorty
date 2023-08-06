//
//  LaunchScreenViewController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 17.07.2023.
//

import UIKit

final class LaunchScreenViewController: BaseViewController {
    
    private var viewModel: LaunchScreeenViewModel!
    
    // MARK: - Views
    private let backView: UIView = {
        var view = UIView()
        view.backgroundColor = BaseColor.hex_C1ECC5
        return view
    }()
    
    private let launchImage: UIImageView = {
        var image = UIImageView()
        image.image = AppIcons.getIcon(.i_launch_image)
        return image
    }()
    
    // MARK: - View Cycle
    static func create (with viewModel: LaunchScreeenViewModel) -> LaunchScreenViewController {
        let view = LaunchScreenViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        viewModel.preparationFinished()
    }
    
    // MARK: - Private
    private func addSubViews() {
        view.addSubview(backView)
        backView.addSubview(launchImage)
        makeConstraints()
    }
    
    private func makeConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        launchImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
