//
//  SearchBar.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 29.07.2023.
//

import UIKit

final class SearchBar: UIView {
    
    var screenType: ScreenType = .charactersScreen
    var startSearch: StringClosure?
    
    private let searchBarBackView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_F1F6ED
        return view
    }()
    
    private let leftImageView: UIImageView = {
        let image = UIImageView()
        image.image = AppIcons.getIcon(.i_magnifying_glass)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var searchTextField: TextField = {
        let textField = TextField(hPaddings: 32)
        textField.backgroundColor = BaseColor.hex_E0F4E0
        textField.addTarget(self, action: #selector(textEntered), for: .editingChanged)
        textField.leftView = leftImageView
        textField.leftViewMode = .always
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(searchBarBackView)
        searchBarBackView.addSubview(searchTextField)
        makeConstraints()
    }
    
    private func makeConstraints() {
        searchBarBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.leading.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
    }
    
    func clearText() {
        searchTextField.text = ""
    }
    
    @objc private func textEntered() {
        guard let text = searchTextField.text else { return }
        startSearch?(text)
    }    
}
