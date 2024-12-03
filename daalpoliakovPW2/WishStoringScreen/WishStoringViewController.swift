//
//  WishStoringViewController.swift
//  daalpoliakovPW2
//
//  Created by Danya Polyakov on 04.11.2024.
//

import UIKit

private enum Constants {
    static let colorGrayTableCell = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 0.0)
    static let colorTransparent = UIColor(red:0, green: 0, blue: 0, alpha: 0)
    static let titleHeight = CGFloat(20)
    static let buttonHeight = CGFloat(40)
    static let cornerRadius = CGFloat(10)
    static let tableOffset = CGFloat(10)
    static let numberOfSections = Int(2)
    
    static let deleteVertOffset = CGFloat(15)
    static let deleteHorOffset = CGFloat(260)
    static let textFieldColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let cellStyle: UITableViewCell.SelectionStyle = .gray
    static let wrapColor: UIColor = .white
    static let wrapRadius: CGFloat = 16
    static let wrapOffsetV: CGFloat = 5
    static let wrapOffsetH: CGFloat = 10
    static let wishLabelOffset: CGFloat = 8
    static let textFieldWidth = CGFloat(250)
    static let smallButtonWidth = CGFloat(100)
    static let leadingTextFieldOffset = CGFloat(5)
    static let deleteButtonTitle = "-"
    static let pressedButtonColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
    static let testFieldTitle = "Write your wish"
    static let enterButtonTitle = "Enter"
}


final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "WrittenWishCell"
    
    private let wishLabel: UILabel = UILabel()
    let  deleteButton = CustomButton(title: Constants.deleteButtonTitle, width: Constants.smallButtonWidth)
    let wrap: UIView = UIView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        deleteButton.wasPressed = {[weak self] value in
            self?.backgroundColor = Constants.pressedButtonColor}
        
        selectionStyle = .none
        backgroundColor = Constants.colorTransparent
        self.addSubview(wrap)
        
        wrap.isUserInteractionEnabled = true
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        wrap.addSubview(wishLabel)
        wrap.addSubview(deleteButton)
        deleteButton.pin(to: wrap, Constants.deleteVertOffset, Constants.deleteHorOffset)
        deleteButton.isUserInteractionEnabled = true
        wishLabel.pin(to: wrap, Constants.wishLabelOffset)
    }
}


final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    var addWish: ((String) -> ())?
    
    var textField = CustomTextField(title: Constants.testFieldTitle)
    var fieldButton = CustomButtonWithText(title: Constants.enterButtonTitle)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var wasPressed: ((Bool) -> Void)?
    @objc
    private func LOLbuttonWasPressed(sender: UIButton) {
        wasPressed?(true)
    }
    
    private func configureUI() {
        backgroundColor = Constants.wrapColor
        
        for view in [textField, fieldButton] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        textField.backgroundColor = Constants.textFieldColor
        
        textField.pinLeft(to: leadingAnchor, Constants.leadingTextFieldOffset)
        fieldButton.pinLeft(to: textField, Constants.textFieldWidth)
        
        fieldButton.wasPressed = {[weak self] value in
            self?.backgroundColor = Constants.pressedButtonColor
        }
    }
}


final class WishStoringViewController: UIViewController {
    private let interactor: WishStoringBusinessLogic
    private var backgroundColor: UIColor
    
    private var wishArray: [String] = ["LOL", "KEK", "NOPE", "UUUUUUU"]
    
    private let table: UITableView = UITableView(frame: .zero)
    
    init (interactor: WishStoringBusinessLogic, backgrcol: UIColor) {
        self.interactor = interactor
        self.backgroundColor = backgrcol
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = backgrcol
    }
    
    @available (*, unavailable)
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.colorTransparent
        view.isUserInteractionEnabled = true
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = Constants.colorGrayTableCell
        table.dataSource = self
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = Constants.cornerRadius
        table.rowHeight = Constants.buttonHeight + Constants.titleHeight + Constants.titleHeight
        
        table.pin(to: view, Constants.tableOffset)
        table.isUserInteractionEnabled = true
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    func displayStart(){
        
    }
    
    func displayOther(){
        
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            return wishArray.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            
            wishCell.configure(with: wishArray[indexPath.row])
            wishCell.isUserInteractionEnabled = true
            
            return wishCell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            )
            
            guard let wishCell = cell as? AddWishCell else { return cell }
            
            wishCell.isUserInteractionEnabled = true
            wishCell.wasPressed = {[weak self] value in
                self?.table.backgroundColor = Constants.pressedButtonColor
            }
            
            return wishCell
        }        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
}
