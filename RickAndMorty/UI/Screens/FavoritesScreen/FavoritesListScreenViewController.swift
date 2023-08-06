//
//  FavoritesListScreenViewController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 20.07.2023.
//

import UIKit
import RxSwift

final class FavoritesListScreenViewController: BaseViewController {
    private var viewModel: FavoritesListScreenViewModel!
    
    private var disposeBag = DisposeBag()
    private let defaultSelectedIndex = 0
    
    // MARK: - Views
    
    private let emptyView = FavoriteEmptyView()
    
    private lazy var searchBar: SearchBar = {
        let view = SearchBar()
        view.startSearch = { [weak self] text in
            self?.viewModel.startSearch(searchText: text)}
        return view
    }()
    
    private lazy var segmentedControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl()
        control.backgroundColor = BaseColor.hex_E0F4E0
        control.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        control.setTitleTextAttributes([.foregroundColor : BaseColor.hex_3C864A], for: .normal)
        control.selectedSegmentTintColor = BaseColor.hex_08D430
        control.insertSegment(withTitle: "Characters", at: 0, animated: true)
        control.insertSegment(withTitle: "Episodes", at: 1, animated: true)
        control.insertSegment(withTitle: "Locations", at: 2, animated: true)
        control.selectedSegmentIndex = defaultSelectedIndex
        control.addTarget(self, action: #selector(segemtedControlSelected), for: .valueChanged)
        return control
    }()
    
    private lazy var favoritesListStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(collectionView)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(emptyView)
        return stackView
    }()
    
    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView()
        collectionView.itemLiked = { [weak self] id, _ in
            self?.clearText()
            self?.viewModel.removeLike(id: id)
        }
        collectionView.itemClicked = { [weak self] item in
            self?.viewModel.openItemDetail(model: item)
        }
        return collectionView
    }()
    
    private lazy var tableView: TableView = {
        let tableView = TableView()
        tableView.locationLiked = { [weak self] id, _ in
            self?.viewModel.removeLike(id: id)
        }
        tableView.locationClicked = { [weak self] location in
            self?.viewModel.openItemDetail(model: location)
        }
        return tableView
    }()
    
    // MARK: - View Cycle
    static func create(with viewModel: FavoritesListScreenViewModel) -> FavoritesListScreenViewController {
        let view = FavoritesListScreenViewController()
        view.viewModel = viewModel
        return view
    }
    
    func bind(to viewModel: FavoritesListScreenViewModel) {
        viewModel.onFavoritesListLoadedObservable.subscribe(onNext: { [weak self] items in
            guard let self = self  else { return }
            self.clearText()
            self.configure(items: items, screenType: viewModel.screenType)
        }).disposed(by: disposeBag)
        
        viewModel.onFavoritesListSearchedObservable.subscribe(onNext: { [ weak self] items in
            guard let self = self else { return }
            self.configure(items: items, screenType: viewModel.screenType)
        }).disposed(by: disposeBag)
        
        viewModel.onFavoritesListEmptyObservable.subscribe(onNext: { [ weak self] in
            guard let self = self else { return }
            self.configure(items: [], screenType: viewModel.screenType)
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        bind(to: viewModel)
        viewModel.setScreenType(selectedIndex: defaultSelectedIndex)
    }

    func configure(items: [BaseItemable], screenType: ScreenType) {
        emptyView.isHidden = !items.isEmpty
        tableView.isHidden = (screenType != .locationScreen || items.isEmpty)
        collectionView.isHidden = (screenType == .locationScreen || items.isEmpty)
        collectionView.configure(items: items,
                                 screenType: screenType)
        tableView.configure(items: items)
    }
    
    func clearText() {
        searchBar.clearText()
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(favoritesListStack)
        configureNavBar()
        makeConstraints()
    }
    
    private func configureNavBar() {
        navigationBar.addItem(NavigationBarTitle(title: "Favorites"), toPosition: .title)
    }
    
    private func makeConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(52)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(32)
        }
        
        favoritesListStack.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(24)
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func segemtedControlSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0, 1, 2:
            viewModel.setScreenType(selectedIndex: sender.selectedSegmentIndex)
        default:
            break
        }
    }
}
