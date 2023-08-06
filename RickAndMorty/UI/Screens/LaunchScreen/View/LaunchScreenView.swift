//
//  LaunchScreenView.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import Combine

final class LaunchScreenView: UIView {

    private let backView: UIView = {
        var view = UIView()
        view.backgroundColor = BaseColor.hex_C1ECC5.uiColor()
        return view
    }()
    
    private let launchImage: UIImageView = {
        var image = UIImageView()
        image.image = AppIcons.getIcon(.i_launch_image)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addElements()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(launchImage)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        launchImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(295)
            make.left.equalToSuperview().offset(139)
            make.right.equalToSuperview().offset(-139)
            make.bottom.equalToSuperview().offset(-406)
        }
    }
}

