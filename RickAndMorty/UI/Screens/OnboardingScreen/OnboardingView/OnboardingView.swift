//
//  OnboardingView.swift
//  Education
//
//  Created by iMac on 05.11.2022.
//

import UIKit
import Combine

final class OnboardingView: UIView {
    
    let events = PassthroughSubject<LaunchScreenViewEvent, Never>()
    
    private let contentView: UIView = {
        var view = UIView()
        view.backgroundColor = BaseColor.hex_C1ECC5.uiColor()
        return view
    }()
    
    private let imageFirst: UIImageView = {
        var image = UIImageView()
        image.image = AppIcons.getIcon(.i_onboarding_first)
        return image
    }()
    
    private let imageSecond: UIImageView = {
        var image = UIImageView()
        image.image = AppIcons.getIcon(.i_onboarding_second)
        return image
    }()
    
    private let textInput: UITextField = {
        var input = UITextField()
        input.text = "  Enter your name"
        input.font = InterFont.regular(size: 16)
        input.clearsOnBeginEditing = true
        // Change color
        input.backgroundColor = .lightGray
        input.layer.cornerRadius = 16
        return input
    }()
    
    private let topLabel: UILabel = {
        var label = UILabel()
        label.text = "I’m Pickle"
        label.font = AsaFont.regular(size: 24)
        return label
    }()
    
    private let bottomLabel: UILabel = {
        var label = UILabel()
        label.text = "Вошли и вышли, приключение на 20 минут"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = InterFont.regular(size: 18)
        return label
    }()
    
    private let goButton: UIButton = {
        var button = UIButton()
        button.setTitle("Waba laba dab dab", for: .normal)
        button.titleLabel?.font = LatoFont.regular(size: 14)
        button.backgroundColor = BaseColor.hex_3BB44A.uiColor().withAlphaComponent(0.55)
        button.layer.cornerRadius = 16
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(contentView)
        contentView.addSubview(imageFirst)
        contentView.addSubview(imageSecond)
        contentView.addSubview(textInput)
        contentView.addSubview(goButton)
        contentView.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageFirst.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(105)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-59)
            make.bottom.equalToSuperview().offset(-487)
        }
        
        imageSecond.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(314)
            make.left.equalToSuperview().offset(118)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-250)
        }
        
        textInput.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(183)
            make.left.equalToSuperview().offset(62)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(36)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(imageFirst.snp.top).offset(32)
            make.left.equalToSuperview().offset(96)
            make.right.equalToSuperview().offset(-132)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(imageSecond.snp.bottom).offset(52)
            make.left.equalToSuperview().offset(74)
            make.right.equalToSuperview().offset(-74)
            make.width.equalTo(227)
        }
        
        goButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(704)
            make.left.equalToSuperview().offset(111)
            make.right.equalToSuperview().offset(-110)
            make.height.equalTo(36)
        }
    }
    
    private func buttonState(isEnable: Bool) {
        goButton.isEnabled = isEnable
        goButton.backgroundColor = isEnable ? BaseColor.hex_3BB44A.uiColor() : BaseColor.hex_3BB44A.uiColor().withAlphaComponent(0.55)
    }
    
    @objc func checkInput(_ textInput: UITextField) {
        guard let text = textInput.text else { return }
        if text.isEmpty {
            buttonState(isEnable: false)
        } else {
            buttonState(isEnable: true)
        }
    }
    
    private func addTargets() {
        goButton.addTarget(self, action: #selector(clickedAction), for: .touchUpInside)
        textInput.addTarget(self, action: #selector(checkInput(_:)), for: .editingChanged)
    }
    
    @objc private func clickedAction() {
        events.send(.buttonInClicked)
    }
}
