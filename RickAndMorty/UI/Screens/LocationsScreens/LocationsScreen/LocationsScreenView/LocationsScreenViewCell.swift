//
//  LocationsScreenViewCell.swift
//  Education
//
//  Created by iMac on 02.11.2022.
//

import UIKit
import Combine

final class LocationsScreenViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = BaseColor.hex_FFFFFF.light
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
