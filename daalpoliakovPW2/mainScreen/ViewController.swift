//
//  ViewController.swift
//  daalpoliakovPW2
//
//  Created by Danya Polyakov on 28.10.2024.
//

import UIKit

private enum Constants {
    static let fontTitle = UIFont.systemFont(ofSize: 32)
    static let fontSmall = UIFont.systemFont(ofSize: 15)
    static let colorTextStart = UIColor(red: 113/255, green: 170/255, blue: 232, alpha: 1.0)
    static let colorBackgroundStart = UIColor(red: 159/255, green: 1, blue: 250/255, alpha: 1.0)
    static let colorBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    static let colorWhite = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
    static let colorTransparent = UIColor(red:0, green: 0, blue: 0, alpha: 0)
    static let verticalConstr = CGFloat(10)
    static let leadingConstr = CGFloat(20)
    static let titleHeight = CGFloat(20)
    static let buttonHeight = CGFloat(40)
    static let smallButtonWidth = CGFloat(100)
    static let largeButtonWidth = CGFloat(300)
    static let textFieldWidth = CGFloat(250)
    static let sliderWidth = CGFloat(300)
    static let searchWidth = CGFloat(100)
    static let stackHeight = CGFloat(75)
    static let stackWidth = CGFloat(350)
    static let cornerRadius = CGFloat(10)
    static let lenHEX = Int(7)
    static let sliderCount = Float(250)
    static let wishButtonText = "My wishes"
    static let middleVerticalConstraint = CGFloat(20)
    static let largeVerticalConstraint = CGFloat(10)
    static let spacing = CGFloat(10)
    static let scheduleButtonText = "Schedule wishes"
    static let sliderRedText = "Red"
    static let sliderGreenText = "Green"
    static let sliderBlueText = "Blue"
    static let myWishesButtonText = "My Wishes"
    static let hideSlidersButtonText = "Hide sliders"
    static let showSlidersButtonText = "Show sliders"
    static let scheduleEventsButtonText = "Schedule events"
    static let randomColorButtonText = "Random color"
    static let enterButtonText = "Enter"
    static let appNameTitle = "Wish Maker"
    static let descriptionTitle = "You can change background color if that is your wish."
    static let textFieldHEXTitle = "Color in HEX"
    static let errorTextFieldMessage = "Please enter color in HEX format"
    static let emptyText = ""
    
    static let redCoeff = CGFloat(1.4)
    static let greenCoeff = CGFloat(1.5)
    static let blueCoeff = CGFloat(1.1)
}

func generate_button_color(background: UIColor) -> UIColor {
    let real_back = CIColor(color: background)

    let r = real_back.red / Constants.redCoeff
    let g = real_back.green / Constants.greenCoeff
    let b = real_back.blue / Constants.blueCoeff
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}

func generate_color() -> UIColor {
    let r = CGFloat.random(in: 0..<1)
    let g = CGFloat.random(in: 0..<1)
    let b = CGFloat.random(in: 0..<1)
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}


//I believe in this function we do not have magic numbers since we analize the structure of specific type
func get_from_hex(hex_col: String, sender: CustomTextField) -> UIColor {
    if (hex_col.count != Constants.lenHEX) {
        sender.titleView.text = Constants.errorTextFieldMessage
        return Constants.colorWhite
    }
    
    var hex: String = hex_col
    
    if (hex.hasPrefix("#")) {
            hex.remove(at: hex.startIndex)
    } else {
        sender.titleView.text = Constants.errorTextFieldMessage
        return Constants.colorWhite
    }

    var hex_int: UInt64 = 0
    let res = Scanner(string: hex).scanHexInt64(&hex_int)
    
    if (res == false) {
        sender.titleView.text = Constants.errorTextFieldMessage
        return Constants.colorWhite
    }
    
    
    let r: CGFloat = CGFloat((hex_int & 0xFF0000) >> 16) / 255.0
    let g: CGFloat = CGFloat((hex_int & 0x00FF00) >> 8) / 255.0
    let b: CGFloat = CGFloat(hex_int & 0x0000FF) / 255.0
    
    return UIColor(red: r, green: g, blue: b, alpha: 1.0)
}


final class CustomSlider: UIView {
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()

    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = Constants.colorTransparent
        translatesAutoresizingMaskIntoConstraints = false

        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
        titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
        titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalConstr),
        titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingConstr),

        slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
        slider.centerXAnchor.constraint(equalTo: centerXAnchor),
        slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalConstr),
        slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingConstr)
        ])
    }

    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}

final class CustomButton: UIView {
    var wasPressed: ((Bool) -> Void)?

    var button = UIButton(type: .system)
    var width = Constants.smallButtonWidth

    init(title: String, width: CGFloat) {
        super.init(frame: .zero)
        self.width = width
        button.setTitle(title, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        button.backgroundColor = Constants.colorTextStart
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [button] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        button.setHeight(Constants.buttonHeight)
        button.setWidth(self.width)
    }

    @objc
    private func buttonWasPressed(sender: UIButton) {
        if sender.tag == 0 {
            wasPressed?(true)
        }
    }
}

final class CustomButtonWithText: UIView {
    var wasPressed: ((Bool) -> Void)?

    var button = UIButton(type: .system)
    var titleView = UILabel()

    init(title: String) {
        super.init(frame: .zero)
        button.setTitle(title, for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        button.backgroundColor = Constants.colorTextStart
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [button, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        titleView.pinTop(to: topAnchor, Constants.verticalConstr)
        button.pinTop(to: titleView.bottomAnchor)
        titleView.setHeight(Constants.titleHeight)
        button.setHeight(Constants.buttonHeight)
        button.setWidth(Constants.smallButtonWidth)
        titleView.setWidth(Constants.smallButtonWidth)
    }

    @objc
    private func buttonWasPressed(sender: UIButton) {
        if sender.tag == 0 {
            wasPressed?(true)
        }
    }
}

final class CustomTextField: UIView {
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
        
        titleView.pinTop(to: topAnchor, Constants.verticalConstr)
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


final class WishMakerViewController: UIViewController {
    private let interactor: WishMakerBusinessLogic
    
    init (interactor: WishMakerBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var curColor: UIColor = Constants.colorBackgroundStart
    private var titleView = UILabel()
    private var descrView = UILabel()
    private var stackSlidersView = UIStackView()
    private var stackRandomButtonView = UIStackView()
    private var stackTextFieldView = UIStackView()
    private let addWishButton: UIButton = UIButton(type: .system)
    private let sceduleWishesButton: UIButton = UIButton(type: .system)
    private let actionStack: UIStackView = UIStackView()
    
    private var viewButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.colorBackgroundStart
        configureTitle()
        configureActionStack()
        configureSliders()
        configureDescription()
        configureButton()
        configureTextField()
    }

    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.appNameTitle
        titleView.font = Constants.fontTitle
        titleView.textColor = Constants.colorTextStart
        view.addSubview(titleView)
        
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func configureDescription() {
        descrView.translatesAutoresizingMaskIntoConstraints = false
        descrView.text = Constants.descriptionTitle
        descrView.font = Constants.fontSmall
        descrView.textColor = Constants.colorTextStart
        view.addSubview(descrView)
        

        descrView.pinCenterX(to: view.centerXAnchor)
        descrView.pinTop(to: titleView, Constants.middleVerticalConstraint)
        descrView.setHeight(Constants.buttonHeight)
        
    }

    private func configureSliders() {
        stackSlidersView.translatesAutoresizingMaskIntoConstraints = false
        stackSlidersView.axis = .vertical
        view.addSubview(stackSlidersView)
        stackSlidersView.layer.cornerRadius = Constants.cornerRadius
        stackSlidersView.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.sliderRedText, min: 0, max: Double(Constants.sliderCount))
        let sliderBlue = CustomSlider(title: Constants.sliderBlueText, min: 0, max: Double(Constants.sliderCount))
        let sliderGreen = CustomSlider(title: Constants.sliderGreenText, min: 0, max: Double(Constants.sliderCount))
        let button = CustomButton(title: Constants.hideSlidersButtonText, width: Constants.largeButtonWidth)
        
        viewButtons.append(button.button)
        
        button.button.layer.cornerRadius = Constants.cornerRadius
        
        for slider in [sliderRed, sliderBlue, sliderGreen, button] {
            stackSlidersView.addArrangedSubview(slider)
        }
        
        stackSlidersView.pinCenterX(to: actionStack.centerXAnchor)
        stackSlidersView.pinBottom(to: actionStack.topAnchor)
        stackSlidersView.setWidth(Constants.sliderWidth)
        stackSlidersView.setHeight(Constants.sliderWidth)
        button.backgroundColor = Constants.colorTransparent
        button.pinCenterX(to: stackSlidersView.centerXAnchor)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.curColor = UIColor(red: CGFloat(sliderRed.slider.value / Constants.sliderCount),
                                                 green: CGFloat(sliderGreen.slider.value / Constants.sliderCount),
                                                 blue: CGFloat(sliderBlue.slider.value / Constants.sliderCount),
                                                 alpha: 1.0
            )
            self?.view.backgroundColor = self?.curColor
            
            for button in self?.viewButtons ?? []{
                button.backgroundColor = generate_button_color(background: self?.curColor ?? Constants.colorWhite)
            }
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.curColor = UIColor(red: CGFloat(sliderRed.slider.value / Constants.sliderCount),
                                                 green: CGFloat(sliderGreen.slider.value / Constants.sliderCount),
                                                 blue: CGFloat(sliderBlue.slider.value / Constants.sliderCount),
                                                 alpha: 1.0
            )
            self?.view.backgroundColor = self?.curColor
            
            for button in self?.viewButtons ?? []{
                button.backgroundColor = generate_button_color(background: self?.curColor ?? Constants.colorWhite)
            }
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.curColor = UIColor(red: CGFloat(sliderRed.slider.value / Constants.sliderCount),
                                                 green: CGFloat(sliderGreen.slider.value / Constants.sliderCount),
                                                 blue: CGFloat(sliderBlue.slider.value / Constants.sliderCount),
                                                 alpha: 1.0
            )
            self?.view.backgroundColor = self?.curColor
            
            for button in self?.viewButtons ?? []{
                button.backgroundColor = generate_button_color(background: self?.curColor ?? Constants.colorWhite)
            }
        }
        
        button.wasPressed = { [weak self] value in
            self?.stackSlidersView.backgroundColor = Constants.colorTransparent
            if sliderRed.isHidden {
                button.button.setTitle(Constants.hideSlidersButtonText, for: .normal)
            } else {
                button.button.setTitle(Constants.showSlidersButtonText, for: .normal)
            }
            
            for view in [sliderRed, sliderBlue, sliderGreen]{
                view.isHidden = (!view.isHidden) ? true : false
            }
        }
    }
    
    private func configureButton() {
        stackRandomButtonView.translatesAutoresizingMaskIntoConstraints = false
        stackRandomButtonView.axis = .vertical
        view.addSubview(stackRandomButtonView)
        stackRandomButtonView.clipsToBounds = true
        
        let button = CustomButton(title: Constants.randomColorButtonText, width: Constants.largeButtonWidth)
        viewButtons.append(button.button)
        
        for view in [button] {
            stackRandomButtonView.addArrangedSubview(view)
        }
        
        stackRandomButtonView.pinCenterX(to: stackSlidersView.centerXAnchor)
        stackRandomButtonView.pinBottom(to: stackSlidersView.topAnchor, Constants.verticalConstr)
        stackRandomButtonView.setWidth(Constants.largeButtonWidth)
        stackRandomButtonView.setHeight(Constants.stackHeight)
        button.pinCenterX(to: stackRandomButtonView.centerXAnchor)
        button.button.layer.cornerRadius = Constants.cornerRadius
        
        button.wasPressed = { [weak self] value in
            self?.curColor = generate_color()
            self?.view.backgroundColor = self?.curColor
            
            for button in self?.viewButtons ?? []{
                button.backgroundColor = generate_button_color(background: self?.curColor ?? Constants.colorWhite)
            }
        }
    }
    
    private func configureTextField() {
        stackTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        stackTextFieldView.axis = .horizontal
        view.addSubview(stackTextFieldView)
        stackTextFieldView.clipsToBounds = true
        
        let field = CustomTextField(title: Constants.textFieldHEXTitle)
        let field_button = CustomButtonWithText(title: Constants.enterButtonText)

        for view in [field, field_button] {
            stackTextFieldView.addArrangedSubview(view)
        }
        
        viewButtons.append(field_button.button)
        
        field_button.pinLeft(to: field, Constants.textFieldWidth)
        
        stackTextFieldView.pinCenterX(to: view.centerXAnchor)
        stackTextFieldView.pinBottom(to: stackRandomButtonView.topAnchor, Constants.verticalConstr)
        stackTextFieldView.setWidth(Constants.stackWidth)
        stackTextFieldView.setHeight(Constants.stackHeight)

        field_button.wasPressed = { [weak self] value in
            self?.curColor = get_from_hex(hex_col: field.textField.text ?? Constants.emptyText, sender: field)
            self?.view.backgroundColor = self?.curColor
            
            for button in self?.viewButtons ?? []{
                button.backgroundColor = generate_button_color(background: self?.curColor ?? Constants.colorWhite)
            }
        }
    }
    
    private func configureActionStack() {
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = Constants.spacing
        
        for button in [addWishButton, sceduleWishesButton] {
            actionStack.addArrangedSubview(button)
        }
        
        configureAddWishButton()
        configureScheduleWishes()
        actionStack.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.largeVerticalConstraint)
        actionStack.pinCenterX(to: view.centerXAnchor)
    }
    
    private func configureAddWishButton() {
        viewButtons.append(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.setWidth(Constants.largeButtonWidth)

        addWishButton.backgroundColor = Constants.colorTextStart
        addWishButton.setTitle(
            Constants.wishButtonText,
            for: .normal
        )
        
        addWishButton.layer.cornerRadius = Constants.cornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureScheduleWishes() {
        viewButtons.append(sceduleWishesButton)
        sceduleWishesButton.setHeight(Constants.buttonHeight)
        sceduleWishesButton.setWidth(Constants.largeButtonWidth)
            
        sceduleWishesButton.backgroundColor = Constants.colorTextStart
        sceduleWishesButton.setTitle(
            Constants.scheduleButtonText,
            for: .normal
        )
        
        sceduleWishesButton.layer.cornerRadius = Constants.cornerRadius
        sceduleWishesButton.addTarget(self, action: #selector(scheduleWishesButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addWishButtonPressed() {
        let wsvc = WishStoringViewController(interactor: WishStoringInteractor(presenter: WishStoringPresenter()),backgrcol: view.backgroundColor ?? Constants.colorBackgroundStart)
        present(wsvc, animated: true)
    }
    
    @objc
    private func scheduleWishesButtonPressed() {
        let vc = WishCalendarViewController(backgroundCol: curColor)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func displayStart(){
        
    }
    
    func displayOther(){
        
    }
}
    
