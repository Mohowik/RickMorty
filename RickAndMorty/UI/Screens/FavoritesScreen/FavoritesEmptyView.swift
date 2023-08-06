//
//  FavoritesEmptyView.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 28.07.2023.
//

import UIKit

final class FavoriteEmptyView: UIView {

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_F1F6ED
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        return stack
    }()
    
    private let emptyImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = AppIcons.getIcon(.i_empty_face)
        return image
    }()
    
    private let emptyTitle: UILabel = {
        let label = UILabel()
        label.font = MainFont.display(size: 18)
        label.text = "Чё пучеглазишь, лайкай свой топ\nи он тут появится"
        label.numberOfLines = 2
        label.textAlignment = .center
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
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(stackView)
        stackView.addArrangedSubview(emptyImage)
        stackView.addArrangedSubview(emptyTitle)
    }
    
    private func makeConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
