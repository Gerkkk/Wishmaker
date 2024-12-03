final class WishCreationInteractor: WishCreationBusinessLogic {
    private let presenter: WishCreationPresentationLogic
    
    init(presenter: WishCreationPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadStart(_ request: WishCreationModel.Start.Request) {
        presenter.presentStart(WishCreationModel.Start.Response())
    }
    
    func loadOther(_ request: WishCreationModel.Other.Request) {
        presenter.presentOther(WishCreationModel.Other.Response())
    }
}
