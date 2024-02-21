//
//  SignInViewController.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 19.02.2024.
//

import UIKit
import SnapKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
        configureViews()
        hideKeyboardWhenTappedAround()
    }
    //Handling DarkTheme
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        textFieldEmail.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        textFieldEmail.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
        
        textFieldPassword.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        textFieldPassword.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
    }
    
    //MARK: - Private properties
    private let helloLabel = {
        let label = UILabel()
        label.textColor = ._111827_FFFFFF
        label.text = "Сәлем"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    private let signInLabel = {
        let label = UILabel()
        label.textColor = ._6_B_7280_9_CA_3_AF
        label.text = "Аккаунтқа кіріңіз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return label
    }()
    
    private let emailLabel = {
        let label = UILabel()
        label.textColor = ._111827_FFFFFF
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        return label
    }()
    
    private let textFieldEmail = {
        let textField = TextFieldWithPadding()
        
        textField.attributedPlaceholder = NSAttributedString(string: "Сіздің email", attributes: [
            .foregroundColor: UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1),
            .font: UIFont(name: "SFProDisplay-Regular", size: 16)!
        ])
        
        let emailImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        emailImage.image = UIImage(resource: .email)
        emailImage.contentMode = .scaleAspectFill
        textField.addSubview(emailImage)
        emailImage.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.leading).inset(16)
            make.top.bottom.equalTo(textField).inset(16)
        }
        
        textField.textColor = UIColor(resource: ._111827_FFFFFF)
        textField.font = UIFont(name: "SFProDisplay-SemiBold", size: 16)
        
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        textField.layer.cornerRadius = 12.0

        textField.addTarget(self, action: #selector(editingDidBeginTextField), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEndTextField), for: .editingDidEnd)
        textField.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
        
        return textField
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.textColor = ._111827_FFFFFF
        label.text = "Құпия сөз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        return label
    }()
    
    private let textFieldPassword = {
        let textField = TextFieldWithPadding()
        textField.attributedPlaceholder = NSAttributedString(string: "Сіздің құпия сөзіңіз", attributes: [
            .foregroundColor: UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1),
            .font: UIFont(name: "SFProDisplay-Regular", size: 16)!
        ])
        
        textField.isSecureTextEntry = true
        
        let passImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        passImage.image = UIImage(resource: .password)
        passImage.contentMode = .scaleAspectFill
        textField.addSubview(passImage)
        passImage.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.leading).inset(16)
            make.top.bottom.equalTo(textField).inset(16)
            make.height.width.equalTo(20)
        }
        
        textField.textColor = UIColor(resource: ._111827_FFFFFF)
        textField.font = UIFont(name: "SFProDisplay-SemiBold", size: 16)
        
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        textField.layer.cornerRadius = 12.0
        textField.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
        
        textField.addTarget(self, action: #selector(editingDidBeginTextField), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEndTextField), for: .editingDidEnd)
        
        return textField
    }()
    
    private let showButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(.show, for: .normal)
        button.addTarget(self, action: #selector(showPass), for: .touchUpInside)
        
        return button
    }()
    
    private let signInButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        button.backgroundColor = UIColor(resource: .mainButton)
        button.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1) //white
        
        button.layer.cornerRadius = 12.0
        
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        return button
    }()
    
    private let noAccLabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: ._111827_FFFFFF)
        label.text = "Аккаунтыңыз жоқ па?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let noAccButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        
        
        button.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        
        button.frame.size.height = 20.0
        button.sizeToFit()
        return button
    }()
    
    private let errorString = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
        label.text = "Қате формат"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
}

//MARK: - Private methods

private extension SignInViewController{
    //MARK: - Initialize
    func initialize(){
        //MARK: - NavBar
        navigationItem.title = " "
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackNavBarButton"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    //MARK: - ConfigureViews
    func configureViews(){
        view.backgroundColor = .BG
        
        //MARK: - Hello Labels
        view.addSubview(helloLabel)
        helloLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        view.addSubview(signInLabel)
        signInLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(helloLabel.snp.bottom)
        }
        
        //MARK: - Textfields
        //email
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(signInLabel.snp.bottom).inset(-29)
        }
        
        view.addSubview(textFieldEmail)
        textFieldEmail.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(emailLabel.snp.bottom).inset(-4)
            make.height.equalTo(56)
        }
        
        view.addSubview(errorString)
        errorString.snp.makeConstraints { make in
            make.top.equalTo(textFieldEmail.snp.bottom).inset(0)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(0)
        }
        
        //password
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(errorString.snp.bottom).inset(-13)
        }
        
        view.addSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(passwordLabel.snp.bottom).inset(-4)
            make.height.equalTo(56)
        }
        
        view.addSubview(showButton)
        showButton.snp.makeConstraints { make in
            make.trailing.equalTo(textFieldPassword.snp.trailing).inset(16)
            make.top.bottom.equalTo(textFieldPassword).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(56)
        }
        
        //MARK: - SignInButton
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldPassword.snp.bottom).inset(-50)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        //MARK: - SignUpButton
        let miniView = UIView()
        miniView.addSubview(noAccLabel)
        miniView.addSubview(noAccButton)
        
        noAccLabel.snp.makeConstraints { make in
            make.trailing.equalTo(noAccButton.snp.leading).inset(-2)
            make.leading.equalTo(miniView.snp.leading)
            make.height.equalTo(22)
            make.centerY.equalTo(miniView)
        }
        
        noAccButton.snp.makeConstraints { make in
            make.trailing.equalTo(miniView.snp.trailing)
            make.centerY.equalTo(miniView)
            make.height.equalTo(22)
        }
        
        view.addSubview(miniView)
        
        miniView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(signInButton.snp.bottom).inset(-24)
            make.height.equalTo(22)
            make.width.lessThanOrEqualTo(300)
        }
        

    }
    
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func showPass(){
        textFieldPassword.isSecureTextEntry.toggle()
    }
    
    @objc func editingDidBeginTextField(textField: UITextField){
        textField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1).cgColor
        errorString.snp.updateConstraints { make in
            make.height.equalTo(0)
            make.top.equalTo(textFieldEmail.snp.bottom).inset(0)
        }
    }
    
    @objc func editingDidEndTextField(textField: UITextField){
        textField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
    }
    
    @objc func signIn(){
        let email = textFieldEmail.text ?? " "
        let password = textFieldPassword.text ?? " "

        if !email.hasSuffix("@mail"){
            self.errorString.snp.updateConstraints { make in
                make.height.equalTo(22)
                make.top.equalTo(textFieldEmail.snp.bottom).inset(-16)
            }
            textFieldEmail.layer.borderColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1).cgColor
            super.updateViewConstraints()
        }
        else{
            SVProgressHUD.show()
            
            let parameters = ["email": email, "password": password]
            
            AF.request(URLs.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData{ response in
                
                SVProgressHUD.dismiss()
                var resultString = ""
                
                if let data = response.data{
                    resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
                
                if response.response?.statusCode == 200{
                    let json = JSON(response.data!)
                    print("JSON:\(json)")
                    if let token = json["accessToken"].string{
                        Storage.sharedInstance.accessToken = token
                        UserDefaults.standard.set(token, forKey: "accessToken")
                        self.startApp()
                    } else{
                        SVProgressHUD.showError(withStatus: "CONNECTION_ERROR")
                    }
                } else{
                    var ErrorString = "CONNECTION_ERROR"
                    if let sCode = response.response?.statusCode{
                        ErrorString = ErrorString + "\(sCode)"
                    }
                    ErrorString = ErrorString + "\(resultString)"
                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
                }
                
            }
        }
    }
    
    
    @objc func goToSignUp(){
        let signUpVC = SignUpViewController()
        navigationController?.show(signUpVC, sender: self)
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    func startApp(){
        let tabBarViewController = TabBarController()
        tabBarViewController.modalPresentationStyle = .fullScreen
        self.present(tabBarViewController, animated: true, completion: nil)
    }
}

//
//extension SignInViewController: UITextFieldDelegate{
//
//    func textFieldDidBeginEditing(_ textField: TextFieldWithPadding) {
//        textField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1).cgColor
//    }
//    
//    func textFieldDidEndEditing(_ textField: TextFieldWithPadding) {
//        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
//    }
//    
//}
