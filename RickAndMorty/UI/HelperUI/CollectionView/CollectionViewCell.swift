//
//  CollectionViewCell.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 12.06.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    var selectLike: BoolClosure?
    
    private var isLiked = false {
        didSet {
            likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
        }
    }
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = BaseColor.hex_FDFDFD
        return view
    }()
    
    private let topLeftTitle: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_A5A5A5
        label.font = MainFont.display(size: 14)
        label.text = "Gender:"
        return label
    }()
    
    private let topRightTitle: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.numberOfLines = 1
        label.font = MainFont.text(size: 14)
        return label
    }()

    private let bottomLeftTitle: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_A5A5A5
        label.font = MainFont.display(size: 14)
        label.text = "Species:"
        return label
    }()
    
    private let bottomRightTitle: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.numberOfLines = 1
        label.font = MainFont.text(size: 14)
        return label
    }()
    
    private let titleName: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.numberOfLines = 1
        label.font = MainFont.text(size: 15)
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppIcons.getIcon(.i_heart), for: .normal)
        return button
    }()
    
    private let defaultImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.image = AppIcons.getIcon(.i_placeholder)
        return image
    }()
    
    private let statusBackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let statusTitle: UILabel = {
        let label = UILabel()
        label.font = MainFont.display(size: 12)
        return label
    }()
    
    private lazy var topStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.addArrangedSubview(topLeftTitle)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(topRightTitle)
        return stackView
    }()

    private lazy var bottomStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.addArrangedSubview(bottomLeftTitle)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(bottomRightTitle)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        defaultImage.image = nil
    }
    
    func configure(item: BaseItemable, type: ScreenType) {
        topStack.isHidden = type == .episodesScreen
        statusBackView.isHidden = type == .episodesScreen
        let isLiked = item.isLiked 
        self.isLiked = isLiked
        switch type {
        case .charactersScreen:
            guard let item = item as? CharactersListItem else { return }
            setCharacter(item: item)
        case .episodesScreen:
            guard let item = item as? EpisodesListItem else { return }
            setEpisode(item: item)
        default:
            break
        }
    }
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(defaultImage)
        backView.addSubview(likeButton)
        backView.addSubview(statusBackView)
        statusBackView.addSubview(statusTitle)
        backView.addSubview(titleName)
        backView.addSubview(topStack)
        backView.addSubview(bottomStack)
        makeConstraints()
    }

    private func makeConstraints() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        likeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(40)
        }
        defaultImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.size.equalTo(143)
        }
        statusBackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
            make.height.equalTo(24)
        }
        statusTitle.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        titleName.snp.makeConstraints { make in
            make.top.equalTo(defaultImage.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        topStack.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(titleName.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(10)
        }
        bottomStack.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func addTargets() {
        likeButton.addTarget(self, action: #selector(clickedLike), for: .touchUpInside)
    }
    
    private func setCharacter(item: CharactersListItem) {
        defaultImage.loadImageCharacters(by: item.image)
        titleName.text = item.name
        topRightTitle.text = item.gender
        bottomRightTitle.text = item.species
        statusTitle.text = item.status
        statusTitle.textColor = item.isAlive ? BaseColor.hex_08D430 : BaseColor.hex_FF644A
        statusBackView.backgroundColor = item.isAlive ? BaseColor.hex_CFFFD4 : BaseColor.hex_FDCDC3
        likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
    }
    
    private func setEpisode(item: EpisodesListItem) {
        defaultImage.image = item.checkSeason()
        titleName.text = item.name
        bottomLeftTitle.text = item.episode
        bottomRightTitle.text = item.airDate.dateEpisode()
        likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
    }
    
    @objc private func clickedLike() {
        isLiked.toggle()
        selectLike?(isLiked)
        likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
    }
}
