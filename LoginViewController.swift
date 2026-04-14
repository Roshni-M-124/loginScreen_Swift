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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load ")
        view.backgroundColor = .white
        
        welcomeLabel.text = "Welcome to Mobicip"
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = .blue
        if traitCollection.userInterfaceIdiom == .pad {
            welcomeLabel.font = UIFont.boldSystemFont(ofSize: 40)
        } else {
            welcomeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        }
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        emailLabel.text = "Enter Email"
        email.borderStyle = .roundedRect
        email.autocapitalizationType = .none
        
        passwordLabel.text = "Enter Password"
        password.borderStyle = .roundedRect
        password.autocapitalizationType = .none
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.layer.cornerRadius = 20
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [emailLabel, email, passwordLabel, password, loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
            
        view.addSubview(stackView)

        let spacer = UILayoutGuide()
        view.addLayoutGuide(spacer)

        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            spacer.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor),
            spacer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: spacer.centerYAnchor),
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        email.text = ""
        password.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
        
    @objc func loginButtonTapped(_ sender:UIButton){
        let validEmail: [String:String] = ["psg@gmail.com":"123",   "cit@gmail.com":"456","mobicip@gmail.com":"567"]
        let enteredEmail = (email.text) ?? ""
        let enteredPasswordText = password.text ?? ""
        if let storedPassword = validEmail[enteredEmail], storedPassword == enteredPasswordText{
            showAlert(title: "Success", message: "Login Successful ",isSuccessful : true)
            }
            else{
                showAlert(title: "Error", message: "Login Unsuccessful ", isSuccessful : false)

            }

    }
    func showAlert(title: String, message: String, isSuccessful: Bool) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){ _ in
            if isSuccessful{
                let homeVC = HomeViewController()
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    

}

