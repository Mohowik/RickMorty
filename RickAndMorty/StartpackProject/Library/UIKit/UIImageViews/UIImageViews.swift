//
//  UIImageViews.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImageCharacters(by imageURL: String, completionHandler: VoidClosure? = nil) {
        guard !imageURL.isEmpty else {
            self.image = AppIcons.getIcon(.i_placeholder)
            return
        }
        
        let path = "\(imageURL)"
        guard let url = URL(string: path) else {
            self.image = AppIcons.getIcon(.i_placeholder)
            return }
        let placeholderView = ImagePreloaderView()
        
        self.kf.setImage(with: url,
                         placeholder: placeholderView) { (result) in
            switch result {
            case .success:
                self.backgroundColor = .clear
            case .failure:
                self.image = AppIcons.getIcon(.i_placeholder)
            }
            completionHandler?()
        }
    }
}
