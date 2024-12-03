

import Foundation

protocol WishStoringBusinessLogic {
    func loadStart(_ request: WishStoringModel.Start.Request)
    func loadOther(_ request: WishStoringModel.Other.Request)
}

protocol WishStoringPresentationLogic {
    func presentStart(_ response: WishStoringModel.Start.Response)
    func presentOther(_ response: WishStoringModel.Other.Response)
    
    func routeTo()
}

