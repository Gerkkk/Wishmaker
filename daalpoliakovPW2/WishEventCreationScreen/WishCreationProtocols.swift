
import Foundation

protocol WishCreationBusinessLogic {
    func loadStart(_ request: WishCreationModel.Start.Request)
    func loadOther(_ request: WishCreationModel.Other.Request)
}

protocol WishCreationPresentationLogic {
    func presentStart(_ response: WishCreationModel.Start.Response)
    func presentOther(_ response: WishCreationModel.Other.Response)
    
    func routeTo()
}

