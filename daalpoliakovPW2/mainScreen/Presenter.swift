//
//  Presenter.swift
//  daalpoliakovPW2
//
//  Created by Danya Polyakov on 03.11.2024.
//
import UIKit

final class WishMakerPresenter: WishMakerPresentationLogic {
    private weak var view: WishMakerViewController?
    
    func presentStart(_ response: WishMakerModel.Start.Response) {
        view?.displayStart()
    }
    
    func presentOther(_ response: WishMakerModel.Other.Response) {
        view?.displayOther()
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
