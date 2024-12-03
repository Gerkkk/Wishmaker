import UIKit

private enum Constants {
    static let colorGrayTableCell = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
    static let colorTransparent = UIColor(red:0, green: 0, blue: 0, alpha: 0)
    static let titleHeight = CGFloat(20)
    static let buttonHeight = CGFloat(40)
    static let cornerRadius = CGFloat(10)
    static let tableOffset = CGFloat(10)
    static let numberOfSections = Int(2)
    static let buttonWidth = CGFloat(350)
    static let newWishButton = "Add new wish to calendar"
    static let middleVerticalConstraint = CGFloat(20)
    static let largeVerticalConstraint = CGFloat(30)
    static let defaultCellHeight = CGFloat(100)
    static let defaultDeltaBoundsWidth = CGFloat(10)
    static let defaultEventName = "Unnamed event"
    static let defaultDescription = ""
    static let minimumInteritemSpacing = CGFloat(0)
    static let minimumLineSpacing = CGFloat(0)
    
    static let cellReuseIdentifier = "cell"
}


final class WishCalendarViewController: UIViewController {
    var backgroundCol: UIColor
    
    init(backgroundCol: UIColor) {
        self.backgroundCol = backgroundCol
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = backgroundCol
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let newWishButton: UIButton = UIButton(type: .system)
    
    private var dataArr: [Event] = []
    private var i: Int = 0
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        configureNewWishButton()
        configureCollection()
    }
    
    private func configureNewWishButton() {
        view.addSubview(newWishButton)
        newWishButton.setHeight(Constants.buttonHeight)
        newWishButton.setWidth(Constants.buttonWidth)
        newWishButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.largeVerticalConstraint)
        newWishButton.pinCenterX(to: view.centerXAnchor)
        
        newWishButton.backgroundColor = generate_button_color(background: backgroundCol)
        newWishButton.setTitle(
            Constants.newWishButton,
            for: .normal
        )
        
        newWishButton.layer.cornerRadius = Constants.cornerRadius
        newWishButton.addTarget(self, action: #selector(newWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Constants.colorTransparent
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets()
        collectionView.reloadData()

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: newWishButton.bottomAnchor, Constants.tableOffset)
        
        if let layout = collectionView.collectionViewLayout as?
        UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
            layout.minimumLineSpacing = Constants.minimumLineSpacing
            layout.invalidateLayout()
        }

        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseIdentifier
        )
        
    }
    
    @objc
    private func newWishButtonPressed() {
        present(WishCreationViewController(interactor: WishCreationInteractor(presenter: WishCreationPresenter()), backgrndCol: view.backgroundColor ?? Constants.colorTransparent), animated: true)
    }
}



// MARK: - UICollectionViewDataSource
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        dataArr = CoreDataManager.shared.fetchEvents()
        i = 0
        return dataArr.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        wishEventCell.configure(
            with: WishEventModel(
                title: dataArr[i].name ?? Constants.defaultEventName,
                startDate: dataArr[i].startDate ?? Date(),
                endDate: dataArr[i].endDate ?? Date(),
                description: dataArr[i].note ?? Constants.defaultDescription
            )
        )
        
        i += 1
        i %= dataArr.count
        
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - Constants.defaultDeltaBoundsWidth,
                      height: Constants.defaultCellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}
