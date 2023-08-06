//
//  CollectionViewFooter.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 12.06.2023.
//

import UIKit

final class CollectionViewFooter: UICollectionViewCell {
    
    var selectDetail: VoidClosure?
    var selectHorizont: VoidClosure?
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .black
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(isShow: Bool) {
        activityIndicator.isHidden = !isShow
        if isShow {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func addElements() {
        addSubview(stackView)
        stackView.addArrangedSubview(activityIndicator)
        makeConstraints()
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
    }
}
