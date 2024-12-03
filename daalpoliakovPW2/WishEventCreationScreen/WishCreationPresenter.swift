
import UIKit

final class WishCreationPresenter: WishCreationPresentationLogic {
    private weak var view: WishCreationViewController?
    
    func presentStart(_ response: WishCreationModel.Start.Response) {
        view?.displayStart()
    }
    
    func presentOther(_ response: WishCreationModel.Other.Response) {
        view?.displayOther()
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
