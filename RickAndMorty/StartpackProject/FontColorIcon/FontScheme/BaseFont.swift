//
//  BaseFont.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 30.09.2022.
//

import UIKit

enum MainFont {
    
    static func display(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "SFProDisplay-Regular", size: size) else { return UIFont() }
        return font
    }
        
    static func text(size: CGFloat) -> UIFont {
        let font = UIFont.systemFont(ofSize: size)
        return font
    }
}

enum ComicSansMSFont {
    static func regular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "ComicSansMS", size: size) else { return UIFont() }
        return font
    }
}
