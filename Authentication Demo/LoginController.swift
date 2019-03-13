//
//  LoginController.swift
//  Authentication Demo
//
//  Created by Jia Rui Shan on 2019/2/18.
//  Copyright © 2019 UC Berkeley. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginController: UITableViewController {
    
    var homeViewController: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: .zero, style: .grouped)

        
        // Add the cancel button to the top left corner of the navigation item
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        // Add the login button to the top right corner of the navigation item
        let loginButton = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(sendLoginRequest))
        self.navigationItem.rightBarButtonItem = loginButton
    }
    
    /// A convenient function that dismisses the current view controller
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// The function that is called when the user presses the 'Login' button
    @objc func sendLoginRequest() {
        
        // Fetch the strings for the username and password which the user has entered
        let usernameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditableTextCell
        let username = usernameCell.textField.text ?? ""
        let passwordCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! EditableTextCell
        let password = passwordCell.textField.text ?? ""
        
        let credentials = JSON(dictionaryLiteral: ("username", username), ("password", password))
                
        /// Connect to localhost through an URLSession
        var loginRequest = URLRequest(url: URL(string: "http://127.0.0.1/login.php")!)
        loginRequest.httpMethod = "POST"
        loginRequest.httpBody = credentials.description.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: loginRequest) { (data, response, error) in
            if let e = error {
                print(e)
                return
            }
            
            do {
                let raw = try JSON(data: data!)
                print(raw)
                DispatchQueue.main.async {
                    self.homeViewController?.loginButton.setTitle("Log out", for: .normal)
                    self.homeViewController?.loginButton.tintColor = redTint
                    self.homeViewController?.loginButton.layer.borderColor = redTint.cgColor
                    self.dismissView()
                }
            } catch {
                guard let msg = String(data: data!, encoding: .utf8) else {
                    print("Unable to parse data string.")
                    return
                }
                DispatchQueue.main.async {
                    // If user can't login, display the error message from the server.
                    let alert = UIAlertController(title: "Login Error", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        task.resume()
    }


}

extension LoginController {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Login Credentials"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = EditableTextCell()
        cell.setup()
        
        switch indexPath.row {
        case 0:
            cell.textField.placeholder = "Username"
            cell.completionHandler = {
                if let p = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EditableTextCell {
                    p.textField.becomeFirstResponder()
                }
            }
        case 1:
            cell.textField.isSecureTextEntry = true
            cell.textField.placeholder = "Password"
            cell.textField.returnKeyType = .done
        default:
            break;
        }
        
        return cell
        
    }
}
