//
//  ViewController.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/22/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 236, g: 157, b: 0)
        let buttonstack = UIStackView(arrangedSubviews: [registerButton, loginButton])
        buttonstack.axis = .horizontal
        buttonstack.distribution = .fillEqually
        buttonstack.spacing = 5.0
        let stackview = UIStackView(arrangedSubviews: [appName, emailTextField,passwordTextField,buttonstack])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackview)
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 5.0
        
        stackview.centerXAnchor.constraint(equalTo : self.view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo : self.view.centerYAnchor, constant: -70).isActive = true
        stackview.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -25).isActive = true
        stackview.heightAnchor.constraint(equalToConstant: 200)
    }
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    let appName: UILabel = {
        let label = UILabel()
        label.text = "Swifty Stock"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Register", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        
        button.addTarget(self, action: #selector(handleregister), for: .touchUpInside)
        
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Login", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        
        button.addTarget(self, action: #selector(handlelogin), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handlelogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Must put email and password")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            let customtabbar = CustomTabBar()
            customtabbar.selectedIndex = 0
            self.present(customtabbar, animated: true, completion: nil)
            
        })
    }
    @objc func handleregister() {
        let register = RegisterController()
        self.present(register, animated: true, completion: nil)
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
