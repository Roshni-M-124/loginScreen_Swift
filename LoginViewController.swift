//
//  ViewController.swift
//  loginScreen
//
//  Created by Mobicip on 14/04/26.
//

import UIKit

class LoginViewController: UIViewController {

    let welcomeLabel = UILabel()
    let email = UITextField()
    let password = UITextField()
    let loginButton = UIButton()
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let spacer = UILayoutGuide()
    let eyeButton = UIButton(type: .system)
    
    var stackViewTopConstraint: NSLayoutConstraint!
    var welcomeLabelTopConstraint: NSLayoutConstraint!
    
    var isKeyboardVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load ")
        view.backgroundColor = .white
        
        setupUI()
        setupLayout()
        setupActions()
        setupKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        email.text = ""
        password.text = ""
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        //modify constraints on landscape mode in iphone
        let isLandscapePhone =
            traitCollection.userInterfaceIdiom == .phone &&
            size.width > size.height

        coordinator.animate(alongsideTransition: { _ in
            
            if isLandscapePhone && !self.isKeyboardVisible {
                self.stackViewTopConstraint.constant = -50
                self.welcomeLabelTopConstraint.constant = 10
            } else if isLandscapePhone && self.isKeyboardVisible{
                self.welcomeLabelTopConstraint.constant = 10
            }
            else{
                self.welcomeLabelTopConstraint.constant = 100
            }
            
            self.view.layoutIfNeeded()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("FirstVC deallocated")
    }

    private func setupUI() {
        
        welcomeLabel.text = "Welcome to Mobicip"
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .blue
        welcomeLabel.font = traitCollection.userInterfaceIdiom == .pad
            ? UIFont.boldSystemFont(ofSize: 40)
            : UIFont.boldSystemFont(ofSize: 20)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        emailLabel.text = "Enter Email"
        email.borderStyle = .roundedRect
        email.autocapitalizationType = .none
        email.tag = 1
        //delegate used to handle return key handling and text validation
        email.delegate = self
        email.keyboardType = .emailAddress
        
        passwordLabel.text = "Enter Password"
        password.borderStyle = .roundedRect
        password.autocapitalizationType = .none
        password.tag = 2
        password.delegate = self
        password.isSecureTextEntry = true
        
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 16, weight: .light),
            forImageIn: .normal
        )
        
        password.rightView = eyeButton
        password.rightViewMode = .always
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.layer.cornerRadius = 20
        loginButton.isEnabled = false
        //modify look of login button to grey tone
        loginButton.alpha = 0.5
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [
            emailLabel, email, passwordLabel, password, loginButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addLayoutGuide(spacer)
        
        stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: spacer.centerYAnchor, constant: -100)
        welcomeLabelTopConstraint = welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130)
        
        NSLayoutConstraint.activate([
            welcomeLabelTopConstraint,
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            spacer.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            spacer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewTopConstraint,
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            email.heightAnchor.constraint(equalToConstant: 40),
            password.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        stackView.setCustomSpacing(35, after: password)
        stackView.setCustomSpacing(25, after: email)
        stackView.setCustomSpacing(5, after: emailLabel)
        stackView.setCustomSpacing(5, after: passwordLabel)
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupKeyboardObservers() {
        //add self as listener to keyboard appearance and dismissal
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func togglePasswordVisibility(_ sender: UIButton) {
        password.isSecureTextEntry.toggle()
        let imageName = password.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        isKeyboardVisible = true
        //extract the keyboard final frame height
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        let keyboardHeight = keyboardFrame.height
        stackViewTopConstraint.constant = -keyboardHeight / 1.2

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        //here UIKit holds closure, closure holds self , but self is not holding UIKit just a functions is called but never stored. so no reference cycle.
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        isKeyboardVisible = false
        stackViewTopConstraint.constant = -100

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        let validEmail: [String:String] = [
            "psg@gmail.com":"123",
            "cit@gmail.com":"456",
            "mobicip@gmail.com":"567"
        ]
        
        let enteredEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let enteredPasswordText = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let storedPassword = validEmail[enteredEmail],
           storedPassword == enteredPasswordText {
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: true)
            
        } else {
            showAlert(title: "Error", message: "Login Unsuccessful ", isSuccessful: false)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        validateTextField()
    }
    
    func showAlert(title: String, message: String, isSuccessful: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self]_ in
            if !isSuccessful {
                
                self?.loginButton.isEnabled = false
                self?.loginButton.alpha = 0.5
                self?.email.text = ""
                self?.password.text = ""
            }
            //self->alert->action->closure->self = strong reference cycle.
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func validateTextField(){
        let emailText = email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let passwordText = password.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
        if !emailText.isEmpty && !passwordText.isEmpty{
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == email{
            password.becomeFirstResponder()
        }
        else if textField == password{
            
            textField.resignFirstResponder()
            validateTextField()
        }
        return false
    }
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool {
        
        if string == " " {
            dismissKeyboard()
            return false
        }
        return true
    }
}
