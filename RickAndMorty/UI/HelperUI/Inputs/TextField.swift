//
//  TextField.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 31.07.2023.
//

import UIKit

class TextField: UITextField {
    
    private let padding: UIEdgeInsets

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init(hPaddings: CGFloat) {
        padding = UIEdgeInsets(top: 0, left: hPaddings, bottom: 0, right: hPaddings)
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: "Search:",
                                                        attributes: [NSAttributedString.Key.foregroundColor : BaseColor.hex_3C864A])
        self.textColor = BaseColor.hex_3C864A
        self.layer.cornerRadius = 10
        self.font = MainFont.display(size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
