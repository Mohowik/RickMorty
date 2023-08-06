//
//  LocarionsListScreenViewController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 18.07.2023.
//

import UIKit
import RxSwift

final class LocationsListScreenViewController: BaseViewController {
    
    private var viewModel: LocationsListScreenViewModel!
    private var disposeBag = DisposeBag()
    
    // MARK: - Views
    private lazy var defaultTableView: TableView = {
        let tableView = TableView()
        tableView.locationClicked = { [weak self] locationModel in
            self?.viewModel.openDetail(model: locationModel)
        }
        tableView.fetchLocations = { [weak self] page in
            self?.viewModel.viewDidLoad(page: page)
        }
        tableView.locationLiked = { [weak self] locationId, isLiked in
            self?.viewModel.setLikeOrDislike(id: locationId, isLiked: isLiked)
        }
        return tableView
    }()
    
    // MARK: - View Cycle
    
    static func create(with viewModel: LocationsListScreenViewModel) -> LocationsListScreenViewController {
        let view = LocationsListScreenViewController()
        view.viewModel = viewModel
        return view
    }
    
    private func bind(to viewModel: LocationsListScreenViewModel) {
        viewModel.onLocationsListLoadedObservable.subscribe(onNext: { [weak self] items, countOfPages in
            self?.defaultTableView.configure(items: items,
                                             countOfPages: countOfPages)
        }).disposed(by: disposeBag)
        viewModel.onLocationsListReloadedObservable.subscribe(onNext: { [weak self] in
            self?.defaultTableView.reloadTableView()
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        bind(to: viewModel)
        viewModel.viewDidLoad(page: 1)
    }
    
    // MARK: - Private
    
    private func addSubviews() {
        view.addSubview(defaultTableView)
        configureNavBar()
        makeConstraints()
    }
    
    private func configureNavBar() {
        let title = NavigationBarTitle(title:"Locations")
        navigationBar.addItem(title, toPosition: .title)
    }
    
    private func makeConstraints() {
        defaultTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
