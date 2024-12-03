

final class WishStoringInteractor: WishStoringBusinessLogic {
    private let presenter: WishStoringPresentationLogic
    
    init(presenter: WishStoringPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadStart(_ request: WishStoringModel.Start.Request) {
        presenter.presentStart(WishStoringModel.Start.Response())
    }
    
    func loadOther(_ request: WishStoringModel.Other.Request) {
        presenter.presentOther(WishStoringModel.Other.Response())
    }
}
