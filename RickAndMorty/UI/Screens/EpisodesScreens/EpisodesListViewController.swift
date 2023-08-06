//
//  EpisodesListViewController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 18.07.2023.
//

import UIKit
import RxSwift

final class EpisodesListViewController: BaseViewController {
    
    private var viewModel: EpisodesListViewModel!
    private var disposeBag = DisposeBag()
    
    // MARK: - Views
    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView()
        return collectionView
    }()
    
    // MARK: - View Cycle
    static func create(with viewModel: EpisodesListViewModel) -> EpisodesListViewController {
        let view = EpisodesListViewController()
        view.viewModel = viewModel
        return view
    }
    
    private func bind(to viewModel: EpisodesListViewModel) {
        viewModel.onEpisodesListLoadedObservable.subscribe(onNext: { [weak self] items, countOfPages in
            self?.collectionView.configure(items: items,
                                           screenType: .episodesScreen,
                                           countOfPages: countOfPages)
        }).disposed(by: disposeBag)
        viewModel.onEpisodesListReloadedObservable.subscribe(onNext: { [weak self] in
            self?.collectionView.reloadCollection()
        }).disposed(by: disposeBag)
        collectionView.itemClicked = { [weak self] episodesModel in
            self?.viewModel.openDetail(model: episodesModel)
        }
        collectionView.fetchItem = { [weak self] page in
            self?.viewModel.viewDidLoad(page: page)
        }
        collectionView.itemLiked = { [weak self] episodeId, isLiked in
            self?.viewModel.setLikeOrDislike(id: episodeId, isLiked: isLiked)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        bind(to: viewModel)
        viewModel.viewDidLoad(page: 1)
    }
    
    // MARK: - Private
    private func addSubviews() {
        view.addSubview(collectionView)
        configureNavBar()
        makeConstraints()
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureNavBar() {
        let title = NavigationBarTitle(title:"Episodes")
        navigationBar.addItem(title, toPosition: .title)
    }
}
