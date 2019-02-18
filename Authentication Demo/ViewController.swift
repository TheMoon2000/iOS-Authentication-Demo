//
//  ViewController.swift
//  Authentication Demo
//
//  Created by Jia Rui Shan on 2019/2/18.
//  Copyright © 2019 UC Berkeley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loginButton: UIButton!
    var welcomeMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .white
        self.title = "User Login Demo"
        
        self.insertLabel()
        self.insertLoginButton()
    }
    
    private func insertLabel() {
        let label = UILabel()
        label.isHidden = true
        label.text = "Welcome!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        welcomeMessage = label
        self.view.addSubview(label)
        
        // Layout constraints
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func insertLoginButton() {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = UIColor(red: 130/255,
                                   green: 180/255,
                                   blue: 250/255,
                                   alpha: 1)
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 23
        
        // Link the button to the login action
        button.addTarget(self, action: #selector(presentLoginView), for: .touchUpInside)
        
        // Add to the main view
        button.translatesAutoresizingMaskIntoConstraints = false
        loginButton = button
        self.view.addSubview(button)
        
        // Layout constraints
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 155).isActive = true
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    @objc func presentLoginView() {
        let loginController = LoginController()
        loginController.homeViewController = self
        let loginView = UINavigationController(rootViewController: loginController)
        self.present(loginView, animated: true, completion: nil)
    }


}

