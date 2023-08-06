//
//  CharactersInfoView.swift
//  Education
//
//  Created by Roman Mokh on 21.05.2023.
//

import SnapKit
import UIKit

final class CharactersInfoView: UIView {
    
    private var backView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        return view
    }()
    
    private let imageStatus: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var titleStatus: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.text(size: 18)
        return label
    }()
    
    private var subtitleRace: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.text(size: 18)
        label.text = "Race"
        return label
    }()
    
    private var titleRace: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.text(size: 18)
        return label
    }()

    private var subtitleGender: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.text(size: 18)
        label.text = "Gender"
        return label
    }()
    
    private var titleGender: UILabel = {
        let label = UILabel()
        label.textColor = BaseColor.hex_1B1919.uiColor()
        label.font = MainFont.text(size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addElements()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(character: CharactersModel) {
        imageStatus.image = character.status == "Alive" ? AppIcons.getIcon(.i_alive) : AppIcons.getIcon(.i_dead)
        titleStatus.text = character.status
        titleGender.text = character.gender
        titleRace.text = character.species
    }
    
    private func addElements() {
        addSubview(backView)
        backView.addSubview(imageStatus)
        backView.addSubview(titleStatus)
        backView.addSubview(subtitleRace)
        backView.addSubview(subtitleGender)
        backView.addSubview(titleRace)
        backView.addSubview(titleGender)
    }
    
    private func makeConstrains() {
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageStatus.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.leading.equalToSuperview()
            make.size.equalTo(10)
        }
        
        titleStatus.snp.makeConstraints { make in
            make.centerY.equalTo(imageStatus)
            make.leading.equalTo(imageStatus.snp.trailing).offset(11)
        }
        
        subtitleRace.snp.makeConstraints { make in
            make.top.equalTo(titleStatus.snp.bottom).offset(6)
            make.leading.equalToSuperview()
        }
        
        subtitleGender.snp.makeConstraints { make in
            make.top.equalTo(subtitleRace.snp.bottom).offset(6)
            make.leading.equalToSuperview()
        }
        
        titleRace.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleRace)
            make.leading.greaterThanOrEqualTo(subtitleRace.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(8)
//            make.leading.greaterThanOrEqualTo(subtitleRace.snp.trailing).offset(5)
        }
        
        titleGender.snp.makeConstraints { make in
            make.centerY.equalTo(subtitleGender)
            make.leading.greaterThanOrEqualTo(subtitleGender.snp.trailing).offset(5)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
    }
}
