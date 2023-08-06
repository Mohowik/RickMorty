//
//  DetailScreenViewModel.swift
//  RickAndMorty
//
//  Created by Roman Mokh on 18.07.2023.
//

import RxSwift

protocol DetailScreenViewModelInput{
    func setLikeOrDislike(isLiked: Bool)
}

protocol DetailScreenViewModelOutput{
    var item: BaseItemable { get }
    var screenType: ScreenType { get }
}
protocol DetailScreenViewModel: DetailScreenViewModelInput, DetailScreenViewModelOutput {}

final class DefaultDetailScreenViewModel: DetailScreenViewModel {

    private let storage: MainStorable
    
    // MARK: - OUTPUT
    
    var item: BaseItemable
    var screenType: ScreenType
    
    // MARK: - Init
    init(item: BaseItemable,
         screenType: ScreenType,
         storage: MainStorable) {
        self.item = item
        self.screenType = screenType
        self.storage = storage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Private
    
    private func setItemState(isLiked: Bool) {
        storage.setOrRemoveLike(screenType, item.id, isLiked)
    }
}

// MARK: - INPUT. View event methods
extension DefaultDetailScreenViewModel {
    
    func setLikeOrDislike(isLiked: Bool) {
        setItemState(isLiked: isLiked)
    }
}
