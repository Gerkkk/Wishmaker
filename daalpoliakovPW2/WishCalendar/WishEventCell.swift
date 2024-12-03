import UIKit

private enum Constants {
    static let offset = CGFloat(20)
    static let cornerRadius = CGFloat(20)
    static let backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
    static let titleColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    static let descriptionColor = UIColor(red: 0, green: 0, blue: 1.0, alpha: 1.0)
    static let dateColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
    
    static let titleTop = CGFloat(5)
    static let titleTopSmall = CGFloat(1)
    static let titleFont = UIFont.systemFont(ofSize: 22)
    static let titleLeading = CGFloat(10)
    static let  dateFont = UIFont.systemFont(ofSize: 10)
    static let  noteFont = UIFont.systemFont(ofSize: 12)
    
    static let wishEventCellReuseIdentifier = "WishEventCell"
}

final class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier: String = Constants.wishEventCellReuseIdentifier
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureStartDateLabel()
        configureEndDateLabel()
        configureDescriptionLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = Constants.titleColor
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = Constants.dateColor
        startDateLabel.pinTop(to: wrapView, Constants.titleTop)
        startDateLabel.font = Constants.dateFont
        startDateLabel.pinLeft(to: titleLabel.trailingAnchor, Constants.titleLeading)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = Constants.dateColor
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.titleTopSmall)
        endDateLabel.font = Constants.dateFont
        endDateLabel.pinLeft(to: titleLabel.trailingAnchor, Constants.titleLeading)
    }
    
    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.textColor = Constants.descriptionColor
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.titleTopSmall)
        descriptionLabel.font = Constants.noteFont
        descriptionLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
}
