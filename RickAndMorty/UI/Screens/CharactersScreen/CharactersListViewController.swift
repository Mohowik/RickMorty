//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit
import RxSwift

final class CharactersListViewController: BaseViewController {
    
    private var viewModel: CharactersListViewModel!
    private var disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let collectionView: CollectionView = {
        let collectionView = CollectionView()
        return collectionView
    }()
    
    // MARK: - View Cycle
    static func create(with viewModel: CharactersListViewModel) -> CharactersListViewController {
        let view = CharactersListViewController()
        view.viewModel = viewModel
        return view
    }

    private func bind(to viewModel: CharactersListViewModel) {
        viewModel.onCharactersListLoadedObservable.subscribe(onNext: { [weak self] items, countOfPages in
            self?.collectionView.configure(items: items,
                                           screenType: .charactersScreen,
                                           countOfPages: countOfPages)
        }).disposed(by: disposeBag)
        viewModel.onCharactersListReloadedObservable.subscribe(onNext: { [weak self] in
            self?.collectionView.reloadCollection()
        }).disposed(by: disposeBag)
        collectionView.itemClicked = { [weak self] characterModel in
            self?.viewModel.openDetail(model: characterModel)
        }
        collectionView.fetchItem = { [weak self] page in
            self?.viewModel.viewDidLoad(page: page)
        }
        collectionView.itemLiked = { [weak self] characterId, isLiked in
            self?.viewModel.setLikeOrDislike(id: characterId, isLiked: isLiked)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureNavBar()
        bind(to: viewModel)
        viewModel.viewDidLoad(page: 1)
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(collectionView)
        configureNavBar()
        makeConstraints()
    }
    
    private func configureNavBar() {
        let title = NavigationBarTitle(title:"Characters")
        navigationBar.addItem(title, toPosition: .title)
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
