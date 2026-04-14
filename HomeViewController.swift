//
//  HomeViewController.swift
//  loginScreen
//
//  Created by Mobicip on 14/04/26.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
                
        let welcomeLabel1 = UILabel()
        welcomeLabel1.text = "Welcome to Mobicip Home Page!"
        welcomeLabel1.font = .systemFont(ofSize: 24, weight: .semibold)
        welcomeLabel1.textAlignment = .center
        welcomeLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel1)
        
        NSLayoutConstraint.activate([
            welcomeLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    
        ])
    }
    
}
