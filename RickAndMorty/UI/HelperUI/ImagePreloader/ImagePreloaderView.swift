//
//  ImagePreloaderView.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 10.07.2023.
//

import UIKit
import Kingfisher

final class ImagePreloaderView: UIView, Placeholder {
    
    var backColor = BaseColor.hex_F1F1F1
    var lineColor = BaseColor.hex_FFFFFF
    
    let gradient = CAGradientLayer()
    let translation = UIViewPropertyAnimator(duration: 1, curve: .linear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureFields()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureFields() {
        gradient.colors = [backColor, lineColor, backColor]
        gradient.locations = [0, 0.5, 1]
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: -2, y: -2)
        gradient.endPoint = CGPoint(x: 2, y: 2)
        layer.cornerRadius = 8
        layer.addSublayer(gradient)
        clipsToBounds = true
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        gradientChangeAnimation.duration = 2
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.fromValue = [-1.0, -0.5, 0.0]
        gradientChangeAnimation.toValue = [1.0, 1.5, 2.0]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: #keyPath(CAGradientLayer.colors))
    }
}
