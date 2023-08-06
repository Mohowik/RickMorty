//
//  TableView.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 12.06.2023.
//

import UIKit

final class TableView: UIView {

    private var locationsList = [BaseItemable]()
    private var page = 1
    private var countOfPages = 1

    var locationLiked: IntAndBoolClosure?
    var locationClicked: ItemClosure?
    var fetchLocations: IntClosure?
    
    private let backView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TableViewCell.self)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = BaseColor.hex_F1F6ED
        table.showsVerticalScrollIndicator = true
        table.separatorStyle = .none
        table.contentInset.bottom = 25
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addElements()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(items: [BaseItemable], countOfPages: Int = 0) {
        self.countOfPages = countOfPages
        locationsList = items
        tableView.tableFooterView = nil
        reloadTableView()
    }
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(tableView)
    }
    
    private func makeConstraints() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }

}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if page < countOfPages && indexPath.row == locationsList.count - 1 {
            page += 1
            fetchLocations?(page)
            let footer = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            tableView.tableFooterView = footer
            footer.startAnimating()
        }
        
        let cell = tableView.dequeueReusableCell(withType: TableViewCell.self, for: indexPath)
        guard let locations = locationsList as? [LocationsListItem] else { return UITableViewCell() }
        cell.configure(item: locationsList[indexPath.row])
        cell.selectLike = { [weak self] isLiked in
            self?.locationLiked?(locations[indexPath.row].id, isLiked)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationClicked?(locationsList[indexPath.row])
    }
}
