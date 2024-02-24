//
//  SignUpViewController.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 21.02.2024.
//

import UIKit
import SnapKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        hideKeyboardWhenTappedAround()
        configureViews()
    }
    //Handling DarkTheme
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        textFieldEmail.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        textFieldEmail.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
        
        textFieldPassword.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        textFieldPassword.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
        
        textFieldPasswordAgain.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
        textFieldPasswordAgain.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
    }
    
    //MARK: - Private properties
    private let registerLabel = {
        let label = UILabel()
        label.textColor = ._111827_FFFFFF
        label.text = "Тіркелу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    private let fillOutLabel = {
        let label = UILabel()
        label.textColor = ._6_B_7280_9_CA_3_AF
        label.text = "Деректерді толтырыңыз"
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
        
        textField.layer.backgroundColor = UIColor(resource: .FFFFFF_1_C_2431).cgColor
        
        textField.addTarget(self, action: #selector(editingDidBeginTextField), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(editingDidEndTextField), for: .editingDidEnd)
        
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
    
    private let passwordLabelAgain = {
        let label = UILabel()
        label.textColor = ._111827_FFFFFF
        label.text = "Құпия сөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        return label
    }()
    
    private let textFieldPasswordAgain = {
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
    
    private let showButtonAgain = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(.show, for: .normal)
        button.addTarget(self, action: #selector(showPassAgain), for: .touchUpInside)
        
        return button
    }()
    
    private let signUpButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        button.backgroundColor = UIColor(resource: .mainButton)
        button.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1) //white
        
        button.layer.cornerRadius = 12.0
        
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return button
    }()
    
    private let haveAccLabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: ._111827_FFFFFF)
        label.text = "Сізде аккаунт бар ма?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let haveAccButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        
        
        button.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        
        button.frame.size.height = 20.0
        button.sizeToFit()
        return button
    }()
    
    private let errorString = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
        label.text = "Мұндай email-ы бар пайдаланушы тіркелген"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let errorStringForMail = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
        label.text = "Қате формат"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()

}

//MARK: - Private methods
private extension SignUpViewController{
    func initialize(){
        view.backgroundColor = .BG
        
        //MARK: - NavBar
        navigationItem.title = " "
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackNavBarButton"), style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func goBack(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func showPass(){
        textFieldPassword.isSecureTextEntry.toggle()
    }
    
    @objc func showPassAgain(){
        textFieldPasswordAgain.isSecureTextEntry.toggle()
    }
    
    @objc func goToSignIn(){
        let signInVC = SignInViewController()
        navigationController?.show(signInVC, sender: self)
    }
    
    @objc func signUp(){
        let email = textFieldEmail.text!
        let password = textFieldPassword.text!
        let passwordAgain = textFieldPasswordAgain.text!
        
        if !email.hasSuffix("@mail"){
            self.errorStringForMail.snp.updateConstraints { make in
                make.height.equalTo(22)
                make.top.equalTo(textFieldEmail.snp.bottom).inset(-16)
            }
            textFieldEmail.layer.borderColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1).cgColor
            super.updateViewConstraints()
            
        } else if password != passwordAgain{
            SVProgressHUD.showError(withStatus: "DIFFERENT_PASS_REPIT")
        }
        else{
            SVProgressHUD.show()
            
            let parameters = ["email": email, "password": password]
            
            AF.request(URLs.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData{ response in
                
                
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
                } else if response.response?.statusCode == 400{
                    self.errorString.snp.updateConstraints { make in
                        make.height.equalTo(22)
                        make.top.equalTo(self.textFieldPasswordAgain.snp.bottom).inset(-16)
                    }
                    super.updateViewConstraints()
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
    
    func startApp(){
        let tabBarViewController = TabBarController()
        tabBarViewController.modalPresentationStyle = .fullScreen
        self.present(tabBarViewController, animated: true, completion: nil)
    }
    
    @objc func editingDidBeginTextField(textField: UITextField){
        textField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1).cgColor
        errorString.snp.updateConstraints { make in
            make.height.equalTo(0)
            make.top.equalTo(textFieldPasswordAgain.snp.bottom).inset(0)
        }
        errorStringForMail.snp.updateConstraints { make in
            make.height.equalTo(0)
            make.top.equalTo(textFieldEmail.snp.bottom).inset(0)
        }
    }
    
    @objc func editingDidEndTextField(textField: UITextField){
        textField.layer.borderColor = UIColor(resource: .textfieldBorder).cgColor
    }
}

//MARK: - Configure views

private extension SignUpViewController{
    func configureViews(){
        //MARK: - Register Labels
        view.addSubview(registerLabel)
        registerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        view.addSubview(fillOutLabel)
        fillOutLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(registerLabel.snp.bottom)
        }
        
        //MARK: - Textfields
        //email
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(fillOutLabel.snp.bottom).inset(-29)
        }
        
        view.addSubview(textFieldEmail)
        textFieldEmail.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(emailLabel.snp.bottom).inset(-4)
            make.height.equalTo(56)
        }
        
        view.addSubview(errorStringForMail)
        errorStringForMail.snp.makeConstraints { make in
            make.top.equalTo(textFieldEmail.snp.bottom).inset(0)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(0)
        }
        
        //password
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(errorStringForMail.snp.bottom).inset(-13)
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
        
        //Again
        view.addSubview(passwordLabelAgain)
        passwordLabelAgain.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(textFieldPassword.snp.bottom).inset(-13)
        }
        
        view.addSubview(textFieldPasswordAgain)
        textFieldPasswordAgain.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(passwordLabelAgain.snp.bottom).inset(-4)
            make.height.equalTo(56)
        }
        
        view.addSubview(showButtonAgain)
        showButtonAgain.snp.makeConstraints { make in
            make.trailing.equalTo(textFieldPasswordAgain.snp.trailing).inset(16)
            make.top.bottom.equalTo(textFieldPasswordAgain).inset(16)
            make.width.equalTo(20)
            make.height.equalTo(56)
        }
        
        view.addSubview(errorString)
        errorString.snp.makeConstraints { make in
            make.top.equalTo(textFieldPasswordAgain.snp.bottom).inset(0)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(0)
        }
        
        
        //MARK: - SignInButton
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(errorString.snp.bottom).inset(-40)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        //MARK: - SignUpButton
        let miniView = UIView()
        miniView.addSubview(haveAccLabel)
        miniView.addSubview(haveAccButton)
        
        haveAccLabel.snp.makeConstraints { make in
            make.trailing.equalTo(haveAccButton.snp.leading).inset(-2)
            make.leading.equalTo(miniView.snp.leading)
            make.height.equalTo(22)
            make.centerY.equalTo(miniView)
        }
        
        haveAccButton.snp.makeConstraints { make in
            make.trailing.equalTo(miniView.snp.trailing)
            make.centerY.equalTo(miniView)
            make.height.equalTo(22)
        }
        
        view.addSubview(miniView)
        
        miniView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(signUpButton.snp.bottom).inset(-24)
            make.height.equalTo(22)
            make.width.lessThanOrEqualTo(300)
        }
        

    }
}
