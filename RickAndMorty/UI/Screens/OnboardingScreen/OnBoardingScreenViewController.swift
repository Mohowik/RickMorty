//
//  OnBoardingScreenViewController.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 18.07.2023.
//

import UIKit

final class OnboardingScreenViewController: BaseViewController {
    
    private var viewModel: OnBoardingScreenViewModel!
    
    // MARK: - Views
    private let contentView: UIView = {
        var view = UIView()
        view.backgroundColor = BaseColor.hex_C1ECC5
        return view
    }()
    
    private let imageFirst: UIImageView = {
        var image = UIImageView()
        image.image = AppIcons.getIcon(.i_onboarding_first)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let imageSecond: UIImageView = {
        var image = UIImageView()
        image.image = AppIcons.getIcon(.i_onboarding_second)
        return image
    }()
    
    private let textInput: TextField = {
        let input = TextField(hPaddings: 10)
        input.placeholder = "Enter your name"
        input.backgroundColor = BaseColor.hex_C1ECC5
        return input
    }()
    
    private let topLabel: UILabel = {
        var label = UILabel()
        label.text = "I am Pickle"
        label.font = ComicSansMSFont.regular(size: 32)
        return label
    }()
    
    private let bottomLabel: UILabel = {
        var label = UILabel()
        label.text = "Вошли и вышли, приключение на 20 минут"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = MainFont.display(size: 18)
        label.textColor = BaseColor.hex_3C864A
        return label
    }()
    
    private let goButton: UIButton = {
        var button = UIButton()
        button.setImage(AppIcons.getIcon(.i_onboarding_button), for: .normal)
        button.layer.cornerRadius = 16
        button.isEnabled = false
        return button
    }()
    
    // MARK: - View Cycle
    static func create (with viewModel: OnBoardingScreenViewModel) -> OnboardingScreenViewController {
        let view = OnboardingScreenViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BaseColor.hex_C1ECC5
        hideNavBar()
        addSubviews()
        addTargets()
    }
    
    // MARK: - Private
    private func addSubviews() {
        view.addSubview(contentView)
        contentView.addSubview(imageFirst)
        contentView.addSubview(imageSecond)
        imageFirst.addSubview(textInput)
        contentView.addSubview(goButton)
        imageFirst.addSubview(topLabel)
        contentView.addSubview(bottomLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageFirst.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(61)
            make.centerX.equalToSuperview()
            make.height.equalTo(220)
            make.width.equalTo(300)
        }
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
        }
        
        textInput.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(213)
            make.top.equalTo(topLabel.snp.bottom).offset(16)
            make.centerX.equalTo(topLabel)
        }
        
        imageSecond.snp.makeConstraints { make in
            make.width.equalTo(206)
            make.height.equalTo(237)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(imageFirst.snp.bottom).offset(-48)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.bottom.equalTo(goButton.snp.top).inset(-40)
            make.leading.trailing.equalToSuperview().inset(86)
        }
        
        goButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    private func buttonState(isEnable: Bool) {
        goButton.isEnabled = isEnable
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
        viewModel.openMainFlow()
    }
}


