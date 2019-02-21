//
//  ViewController.swift
//  Authentication Demo
//
//  Created by Jia Rui Shan on 2019/2/18.
//  Copyright © 2019 UC Berkeley. All rights reserved.
//

import UIKit

let redTint = UIColor(red: 1, green: 0.55, blue: 0.54, alpha: 1)
let blueTint = UIColor(red: 130/255, green: 180/255, blue: 250/255, alpha: 1)

class ViewController: UIViewController {
    
    var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .white
        self.title = "User Login Demo"
        
        self.insertLoginButton()
    }
    
    private func insertLoginButton() {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = blueTint
        button.layer.borderColor = blueTint.cgColor
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
    
    @objc func presentLoginView(_ sender: UIButton) {
        if sender.title(for: .normal) == "Login" {
            let loginController = LoginController()
            loginController.homeViewController = self
            let loginView = UINavigationController(rootViewController: loginController)
            self.present(loginView, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Log Out?", message: "You will be signed out.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Log out", style: .default, handler: { (action) in
                sender.setTitle("Login", for: .normal)
                sender.tintColor = blueTint
                sender.layer.borderColor = blueTint.cgColor
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }


}

