//
//  UIView.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

extension UIView {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        tapGesture.cancelsTouchesInView = false //эта строка нужна чтобы не блокировать didSelectItem у CollectionView и TableView
        addGestureRecognizer(tapGesture)
    }
}
