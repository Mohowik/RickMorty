//
//  DetailLocationView.swift
//  Education
//
//  Created by Roman Mokh on 26.05.2023.
//

import UIKit
import Combine

final class DetailLocationView: UIView {
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let locationsInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    private let locationType: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.text(size: 18)
        return label
    }()
    
    private let locationDimension: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.text(size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addElements()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(location: LocationsModel) {
        locationType.text = location.type
        locationDimension.text = location.dimension
    }
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(locationsInfoStack)
        locationsInfoStack.addArrangedSubview(locationType)
        locationsInfoStack.addArrangedSubview(locationDimension)
    }
    
    private func makeConstraints() {
        
        backView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        locationsInfoStack.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
