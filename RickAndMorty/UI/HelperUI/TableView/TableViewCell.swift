//
//  TableViewCell.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 12.06.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    private var isLiked = false {
        didSet {
            likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
        }
    }
    var selectLike: BoolClosure?
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let imageLocation: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.image = AppIcons.getIcon(.i_placeholder)
        return image
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppIcons.getIcon(.i_heart), for: .normal)
        return button
    }()
    
    private let locationsInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 6
        stack.axis = .vertical
        return stack
    }()
    
    private let locationName: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.font = MainFont.text(size: 16)
        return label
    }()
    
    private let locationType: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.font = MainFont.text(size: 16)
        return label
    }()
    
    private let locationDimension: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.font = MainFont.text(size: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLocation.image = nil
    }
    
    func configure(item: BaseItemable) {
        guard let location = item as? LocationsListItem else { return }
        locationName.text = location.name
        locationType.text = location.type
        locationDimension.text = location.dimension
        imageLocation.image = location.type == "Planet" ?  AppIcons.getIcon(.i_planet) : AppIcons.getIcon(.i_universe)
        let isLiked = item.isLiked 
        likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
        self.isLiked = isLiked
    }
    
    private func addElements() {
        contentView.addSubview(backView)
        backView.addSubview(imageLocation)
        backView.addSubview(likeButton)
        backView.addSubview(locationsInfoStack)
        locationsInfoStack.addArrangedSubview(locationName)
        locationsInfoStack.addArrangedSubview(locationType)
        backView.addSubview(locationDimension)
        makeConstraints()
    }
    
    private func makeConstraints() {
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        imageLocation.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.top.bottom.leading.equalToSuperview().inset(10)
        }
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(4)
            make.size.equalTo(40)
        }
        locationsInfoStack.snp.makeConstraints { make in
            make.top.equalTo(imageLocation.snp.top)
            make.leading.equalTo(imageLocation.snp.trailing).offset(8)
            make.trailing.equalTo(likeButton.snp.leading).inset(8)
        }
        locationDimension.snp.makeConstraints { make in
            make.leading.equalTo(imageLocation.snp.trailing).offset(8)
            make.bottom.equalTo(imageLocation.snp.bottom)
        }
    }
    
    private func addTargets() {
        likeButton.addTarget(self, action: #selector(clickedLike), for: .touchUpInside)
    }
    
    @objc private func clickedLike() {
        isLiked.toggle()
        selectLike?(isLiked)
        likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
    }
}
