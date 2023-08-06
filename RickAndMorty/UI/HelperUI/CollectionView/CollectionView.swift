//
//  EpisodesScreenCollectionView.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 12.06.2023.
//

import UIKit

final class CollectionView: UICollectionReusableView {
    
    var itemClicked: ItemClosure?
    var fetchItem: IntClosure?
    var itemLiked: IntAndBoolClosure?
    
    private var itemList = [BaseItemable]()
    private var screenType: ScreenType?
    private var countOfPages = 1
    private var page = 1
    
    private lazy var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self)
        collectionView.register(CollectionViewFooter.self, kind: .footer)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        collectionView.backgroundColor = BaseColor.hex_F1F6ED
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(items: [BaseItemable]?, screenType: ScreenType, countOfPages: Int = 0) {
        guard let items = items else { return }
        self.screenType = screenType
        self.countOfPages = countOfPages
        itemList = items
        reloadCollection()
    }
    
    func reloadCollection() {
        collectionView.reloadData()
    }
    
    private func addElements() {
        addSubview(collectionView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let screenType = screenType else { return UICollectionViewCell() }
        let cell = collectionView.dequeueCollectionReusableCell(withType: CollectionViewCell.self, for: indexPath)
        cell.configure(item: itemList[indexPath.row], type: screenType)
        cell.selectLike = { [weak self] isLiked in
            guard let self = self else { return }
            self.itemLiked?(self.itemList[indexPath.row].id, isLiked)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemClicked?(itemList[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddings: CGFloat = 48.0
        let numberOfItemsPerRow: CGFloat = 2
        let width = (collectionView.frame.width - paddings) / numberOfItemsPerRow
        return CGSize(width: width, height: 238)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueCollectionView(withType: CollectionViewFooter.self, for: indexPath, kind:  UICollectionReusableViewKind.footer.getValue()) as! CollectionViewFooter
        page += 1
        if page < countOfPages + 1 {
            fetchItem?(page)
            view.configure(isShow: true)
        } else {
            view.configure(isShow: false)
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if page < countOfPages {
            return CGSize(width: 50.0, height: 50.0)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}


