//
//  NavigationBar.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 12.06.2023.
//

import UIKit

final class NavigationBar: UIView {

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_F1F6ED
        view.clipsToBounds = true
        return view
    }()

    private let leftSideItemView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    private let rightSideItemView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    private let titleItemView: UIView = {
        let view = UIView()
        return view
    }()

    private let bottomLineView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showBottomLine() {
        bottomLineView.isHidden = false
    }

    func addItem(_ view: UIView, toPosition: NavigationBarItemPosition) {

        switch toPosition {
        case .leftSide:
            leftSideItemView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.top.lessThanOrEqualToSuperview()
                make.bottom.greaterThanOrEqualToSuperview()
                make.centerY.leading.trailing.equalToSuperview()
            }
            leftSideItemView.isHidden = false
        case .title:
            titleItemView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.top.lessThanOrEqualToSuperview()
                make.bottom.greaterThanOrEqualToSuperview()
                make.center.trailing.leading.equalToSuperview()
            }
        case .rightSide:
            rightSideItemView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.top.lessThanOrEqualToSuperview()
                make.bottom.greaterThanOrEqualToSuperview()
                make.centerY.trailing.leading.equalToSuperview()
            }
            rightSideItemView.isHidden = false
        }
    }

    func hideItem(inPosition: NavigationBarItemPosition) {
        switch inPosition {
        case .leftSide:
            leftSideItemView.isHidden = true
        case .title:
            titleItemView.isHidden = true
        case .rightSide:
            rightSideItemView.isHidden = true
        }
    }

    func unhideItem(inPosition: NavigationBarItemPosition) {
        switch inPosition {
        case .leftSide:
            leftSideItemView.isHidden = false
        case .title:
            titleItemView.isHidden = false
        case .rightSide:
            rightSideItemView.isHidden = false
        }
    }
    
    func configureBySearchField() {
        leftSideItemView.isHidden = true
        rightSideItemView.isHidden = true
        titleItemView.snp.remakeConstraints { (make) in
            make.center.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func addElements() {
        addSubview(backView)
        backView.addSubview(leftSideItemView)
        backView.addSubview(titleItemView)
        backView.addSubview(rightSideItemView)
        backView.addSubview(bottomLineView)
        makeConstraints()
    }

    private func makeConstraints() {
        backView.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.trailing.leading.bottom.equalToSuperview()
        }

        leftSideItemView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(9)
            make.height.equalTo(18)
        }

        titleItemView.snp.makeConstraints { (make) in
            make.leading.equalTo(leftSideItemView.snp.trailing).offset(10)
            make.trailing.equalTo(rightSideItemView.snp.leading).inset(10)
            make.center.top.bottom.equalToSuperview()
        }

        rightSideItemView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }

        bottomLineView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

enum NavigationBarItemPosition {
    case leftSide
    case rightSide
    case title
}
