//
//  UICollectionViewDequeue.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

extension UICollectionView {
    
    func dequeueCollectionView<View: UICollectionReusableView>(withType type: View.Type, for indexPath: IndexPath, kind: String) -> UICollectionReusableView {
        
        let indetifier = String(describing: type)
        let view = self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: indetifier,
            for: indexPath
        )
        return view
    }
    
    func dequeueCollectionReusableCell<View: UICollectionViewCell>(withType type: View.Type, for indexPath: IndexPath) -> View {
        let indetifier = String(describing: type)
        let cell = self.dequeueReusableCell(withReuseIdentifier: indetifier, for: indexPath) as! View
        return cell
    }
    
    func register<View: UICollectionViewCell>(_ cellClass: View.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: "\(cellClass)")
    }
    
    func register<View: UICollectionReusableView>(_ viewClass: View.Type, kind: UICollectionReusableViewKind) {
        self.register(viewClass, forSupplementaryViewOfKind: kind.getValue(), withReuseIdentifier: "\(viewClass)")
    }
    
}

enum UICollectionReusableViewKind: String {
    case header
    case footer
    
    func  getValue() -> String {
        switch self {
        case .header:
            return UICollectionView.elementKindSectionHeader
        case .footer:
            return UICollectionView.elementKindSectionFooter
        }
    }
}
