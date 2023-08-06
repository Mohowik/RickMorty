//
//  UITableViewDequeue.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<View: UITableViewCell>(withType type: View.Type, for indexPath: IndexPath) -> View {
        let indetifier = String(describing: type)
        let cell = self.dequeueReusableCell(withIdentifier: indetifier, for: indexPath) as! View
        return cell
    }
    
    func register<View: UITableViewCell>(nibType: View.Type) {
        let identifier = String(describing: nibType)
        let bundle = Bundle(for: nibType)
        let nib = UINib(nibName: identifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func register<View: UITableViewCell>(_ cellClass: View.Type) {
        self.register(cellClass, forCellReuseIdentifier: "\(cellClass)")
    }
    
    func register<View: UITableViewHeaderFooterView>(_ viewClass: View.Type) {
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: "\(viewClass)")
    }
    
    func dequeueReusableSectionHeaderFooter<View: UITableViewHeaderFooterView>(withType type: View.Type, for section: Int) -> View {
        let indetifier = String(describing: type)
        let cell = self.dequeueReusableHeaderFooterView(withIdentifier: indetifier) as! View
        return cell
    }
}
