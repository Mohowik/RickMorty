//
//  DetailScreenController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 24.05.2023.
//

import UIKit
import RxSwift

final class DetailScreenController: BaseViewController {
    private var viewModel: DetailScreenViewModel!
    private var disposeBag = DisposeBag()
    
    private var isLiked = false
    
    // MARK: - Views
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_FFFFFF
        return view
    }()
    
    private let titleName: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.numberOfLines = 2
        label.font = MainFont.text(size: 18)
        return label
    }()
    
    private let imageDetail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = AppIcons.getIcon(.i_placeholder)
        return image
    }()
    
    private let topTitle: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.font = MainFont.text(size: 18)
        return label
    }()
    
    private let bottomTitle: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_424242
        label.font = MainFont.text(size: 18)
        return label
    }()
    
    private lazy var infoLabelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(topTitle)
        stackView.addArrangedSubview(bottomTitle)
        return stackView
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppIcons.getIcon(.i_heart), for: .normal)
        return button
    }()
    
    // MARK: - View Cycle
    static func create (with viewModel: DetailScreenViewModel) -> DetailScreenController {
        let view = DetailScreenController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addElements()
        configureDetail(item: viewModel.item)
    }
    
    func configureDetail(item: BaseItemable) {
        switch viewModel.screenType {
        case .charactersScreen:
            guard let character = item as? CharactersListItem else { return }
            imageDetail.loadImageCharacters(by: character.image)
            titleName.text = character.name
            topTitle.text = character.gender
            bottomTitle.text = character.species
        case .episodesScreen:
            guard let episode = item as? EpisodesListItem else { return }
            titleName.text = episode.name
            imageDetail.image = episode.checkSeason()
            topTitle.text = episode.airDate
            bottomTitle.text = episode.episode
        case .locationScreen:
            guard let location = item as? LocationsListItem else { return }
            imageDetail.image = location.type == "Planet" ?  AppIcons.getIcon(.i_planet) : AppIcons.getIcon(.i_universe)
            titleName.text = location.name
            topTitle.text = location.type
            bottomTitle.text = location.dimension
        }
        let isLiked = item.isLiked 
        likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
        self.isLiked = isLiked
    }
    
    // MARK: - Private
    
    private func addElements() {
        view.addSubview(backView)
        backView.addSubview(imageDetail)
        backView.addSubview(likeButton)
        backView.addSubview(titleName)
        backView.addSubview(infoLabelStack)
        configureNavBar()
        makeConstraints()
        addTargets()
    }
    
    private func configureNavBar() {
        let title = NavigationBarTitle(title:"Detail")
        navigationBar.addItem(title, toPosition: .title)
    }
    
    private func makeConstraints() {
        backView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        imageDetail.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(imageDetail.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.center.equalTo(titleName)
            make.size.equalTo(50)
        }
        titleName.snp.makeConstraints { make in
            make.top.equalTo(imageDetail.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        infoLabelStack.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(20)
            make.top.equalTo(titleName.snp.bottom).offset(8)
        }
    }
    
    private func addTargets() {
        likeButton.addTarget(self, action: #selector(clickedLike), for: .touchUpInside)
    }
    
    @objc private func clickedLike() {
        isLiked.toggle()
        viewModel.setLikeOrDislike(isLiked: isLiked)
        likeButton.setImage(isLiked ? AppIcons.getIcon(.i_heart_like) : AppIcons.getIcon(.i_heart), for: .normal)
        backActionClosure()
    }
}
