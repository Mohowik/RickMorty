//
//  NavigationBarTitle.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

final class NavigationBarTitle: UIView {
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = ComicSansMSFont.regular(size: 26)
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    init(title: String = "",
         isInteractable: Bool = false,
         titleTextColor: UIColor = BaseColor.hex_424242) {
        super.init(frame: .zero)
        titleLabel.text = title
        titleLabel.textColor = titleTextColor
        addElements()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(title: String, subTitle: String = "", isInteractable: Bool = false){
        titleLabel.text = title
    }
    
    private func addElements() {
        addSubview(stackView)
        mainView.addSubview(titleLabel)
        stackView.addArrangedSubview(titleLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(32)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.leading.greaterThanOrEqualToSuperview()
            make.bottom.trailing.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
    }
}
