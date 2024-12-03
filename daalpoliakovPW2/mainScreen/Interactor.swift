//
//  Interactor.swift
//  daalpoliakovPW2
//
//  Created by Danya Polyakov on 03.11.2024.
//

final class WishMakerInteractor: WishMakerBusinessLogic {
    private let presenter: WishMakerPresentationLogic
    
    init(presenter: WishMakerPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadStart(_ request: WishMakerModel.Start.Request) {
        presenter.presentStart(WishMakerModel.Start.Response())
    }
    
    func loadOther(_ request: WishMakerModel.Other.Request) {
        presenter.presentOther(WishMakerModel.Other.Response())
    }
}
