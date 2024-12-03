import UIKit

private enum Constants {
    static let colorGrayTransp = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 0.2)
    static let colorGrayTableCell = UIColor(red: 187/255, green: 187/255, blue:187/255, alpha: 1.0)
    static let colorTransparent = UIColor(red:0, green: 0, blue: 0, alpha: 0)
    static let titleHeight = CGFloat(20)
    static let buttonHeight = CGFloat(40)
    static let cornerRadius = CGFloat(10)
    static let tableOffset = CGFloat(10)
    static let numberOfSections = Int(2)
    static let smallVerticalConstr = CGFloat(10)
    static let verticalConstr = CGFloat(50)
    static let buttonWidth = CGFloat(350)
    static let textFieldWidth = CGFloat(350)
    static let spacing = CGFloat(50)
    static let newEnterButton = "Add new event to calendar"
    static let titleViewText = "Please enter new event"
    static let nameTextFieldTitle = "Task name"
    static let startDateTextFieldTitle = "Start date. Format: dd-MM-yyyy"
    static let endDateTextFieldTitle = "End date. Format: dd-MM-yyyy"
    static let descriptionTextFieldTitle = "Task description"
    static let formatterIdentifier = "en_US_POSIX"
    static let formatterDateFormat = "dd-MM-yyyy"
    static let defaultName = "Unnamed"
    static let emptyString = ""
    static let defaultId = 0;
}

final class CustomNameTextField: UIView {
    var wasChanged: ((Bool) -> Void)?
    var textField = UITextField()
    var titleView = UILabel()
    

    init(title: String) {
        super.init(frame: .zero)
        titleView.text = title
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = Constants.colorTransparent
        translatesAutoresizingMaskIntoConstraints = false

        for view in [textField, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleView.pinTop(to: topAnchor, Constants.smallVerticalConstr)
        titleView.setWidth(Constants.textFieldWidth)
        textField.pinTop(to: titleView.bottomAnchor)
        textField.setHeight(Constants.buttonHeight)
        textField.setWidth(Constants.textFieldWidth)
        textField.backgroundColor = .white
    }

    @objc
    private func textWasChanged(sender: UITextField) {
        wasChanged?(true)
    }
}


final class WishCreationViewController: UIViewController {
    private let interactor: WishCreationBusinessLogic
    var backgroundCol: UIColor
    
    init(interactor: WishCreationInteractor, backgrndCol: UIColor) {
        self.interactor = interactor
        self.backgroundCol = backgrndCol
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = backgrndCol
    }
    
    var actionStack = UIStackView()
    var titleView = UILabel()
    var nameTextField = CustomNameTextField(title: Constants.nameTextFieldTitle)
    var startDateTextField = CustomNameTextField(title: Constants.startDateTextFieldTitle)
    var endDateTextField = CustomNameTextField(title: Constants.endDateTextFieldTitle)
    var descriptionTextField = CustomNameTextField(title: Constants.descriptionTextFieldTitle)
    var enterButton = UIButton(type: .system)
    
    @available (*, unavailable)
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        actionStack.spacing = Constants.spacing
        actionStack.axis = .vertical
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionStack)
        actionStack.clipsToBounds = true
        actionStack.pinCenterX(to: view.centerXAnchor)
        actionStack.backgroundColor = view.backgroundColor

        for view in [titleView, nameTextField, startDateTextField, endDateTextField, descriptionTextField, enterButton] {
            actionStack.addArrangedSubview(view)
            view.pinCenterX(to: actionStack.centerXAnchor)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleView.text = Constants.titleViewText
        titleView.setWidth(Constants.textFieldWidth)
        titleView.setHeight(Constants.buttonHeight)
        
        nameTextField.setHeight(Constants.buttonHeight)
        nameTextField.setWidth(Constants.textFieldWidth)
        
        startDateTextField.setHeight(Constants.buttonHeight)
        startDateTextField.setWidth(Constants.textFieldWidth)
        
        endDateTextField.setHeight(Constants.buttonHeight)
        endDateTextField.setWidth(Constants.textFieldWidth)
        
        descriptionTextField.setHeight(Constants.buttonHeight)
        descriptionTextField.setWidth(Constants.textFieldWidth)
        
        enterButton.setHeight(Constants.buttonHeight)
        enterButton.setTitle(
            Constants.newEnterButton,
            for: .normal
        )
        
        enterButton.backgroundColor = generate_button_color(background: self.backgroundCol)
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        enterButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    @objc
    private func enterButtonPressed() {
        let Formatter = DateFormatter()
        Formatter.locale = Locale(identifier: Constants.formatterIdentifier)
        Formatter.dateFormat = Constants.formatterDateFormat
        
        let start = Formatter.date(from: startDateTextField.textField.text ?? Constants.emptyString) ?? Date()
        let end = Formatter.date(from: endDateTextField.textField.text ?? Constants.emptyString) ?? Date()
        let description = descriptionTextField.textField.text ?? Constants.emptyString
        

        CoreDataManager.shared.createEvent(id: Constants.defaultId, name: nameTextField.textField.text ?? Constants.defaultName, startDate: start, endDate: end, notes: description)
        
        let cm = CalendarManager()
        
        var newWish = WishEventModel(title: nameTextField.textField.text ?? Constants.defaultName, startDate: start, endDate: end)
        newWish.description = description
        
        let _ = cm.create(eventModel: newWish)
        
        dismiss(animated: true)
    }
    
    func displayStart() {}
    func displayOther() {}
}

