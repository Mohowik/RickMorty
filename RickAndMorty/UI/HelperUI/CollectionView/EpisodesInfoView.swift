//
//  EpisodesView.swift
//  Education
//
//  Created by Roman Mokh on 21.05.2023.
//

import UIKit
import Combine

final class EpisodesInfoView: UIView {
    
    private var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        return view
    }()
    
    private let episodeInfo: UILabel = {
        let label = UILabel()
        return label
    }()
   
    private let labelData: UILabel = {
        let label = UILabel()
        label.font = MainFont.text(size: 13)
        return label
    }()
    
    private let episodesHorizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addElements()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(episode: EpisodesModel) {
        episodeInfo.text = episode.episode
        labelData.text = episode.air_date
    }
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(episodesHorizontalStack)
        episodesHorizontalStack.addArrangedSubview(episodeInfo)
        episodesHorizontalStack.addArrangedSubview(labelData)
    }
    
    private func makeConstraints() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        episodesHorizontalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}
