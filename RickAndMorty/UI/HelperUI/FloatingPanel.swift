//
//  FloatingPanel.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import FloatingPanel

class FloatingLayout: FloatingPanelLayout {
    
    var guide: UILayoutGuide
    var heightKeyboard: CGFloat
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: heightKeyboard, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelAdaptiveLayoutAnchor(absoluteOffset: 0.5, contentLayout: guide)
        ]
    }
    
    init(guide: UILayoutGuide, heightKeyboard: CGFloat) {
        self.heightKeyboard = heightKeyboard
        self.guide = guide
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        case .full, .half: return 0.5
        default: return 0.0
        }
    }
}
