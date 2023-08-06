//
//  SaveItemsScreenTableViewCell.swift
//  Education
//
//  Created by iMac on 13.11.2022.
//

import Foundation
import UIKit
import Combine

final class SaveItemsScreenTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
