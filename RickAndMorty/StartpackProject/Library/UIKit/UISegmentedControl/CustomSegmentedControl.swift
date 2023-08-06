//
//  CastomSegmentedControl.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 28.07.2023.
//

import UIKit

final class CustomSegmentedControl: UISegmentedControl {
    override func layoutSubviews() {
        super.layoutSubviews()
        for i in 0..<numberOfSegments where subviews[i] is UIImageView {
            subviews[i].isHidden = true
        }
    }
}
