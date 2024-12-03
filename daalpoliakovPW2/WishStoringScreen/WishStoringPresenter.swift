

import UIKit

final class WishStoringPresenter: WishStoringPresentationLogic {
    private weak var view: WishStoringViewController?
    
    func presentStart(_ response: WishStoringModel.Start.Response) {
        view?.displayStart()
    }
    
    func presentOther(_ response: WishStoringModel.Other.Response) {
        view?.displayOther()
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
