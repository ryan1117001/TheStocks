//
//  RegisterController.swift
//  TheStocks
//
//  Created by Ryan Hua on 4/22/18.
//  Copyright © 2018 Ryan Hua. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {

    let profileurl: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Profile Url"
        tf.text = "api_key"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let fullnameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name"
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
    let funding: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Initial Funding"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Register", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        
        button.addTarget(self, action: #selector(profileCreate), for: .touchUpInside)
        
        return button
    }()
    let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Exit", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 236, g: 157, b: 0)
        
        let buttonstack = UIStackView(arrangedSubviews: [exitButton,registerButton])
        buttonstack.axis = .horizontal
        buttonstack.distribution = .fillEqually
        buttonstack.spacing = 5.0
        
        let stackview = UIStackView(arrangedSubviews: [emailTextField,usernameTextField,passwordTextField,fullnameTextField, funding, buttonstack])
        view.addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 5.0
        stackview.centerXAnchor.constraint(equalTo : self.view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo : self.view.centerYAnchor).isActive = true
        stackview.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -25).isActive = true
        stackview.heightAnchor.constraint(equalToConstant: 300)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func exit() {
        let lc = LoginController()
        self.present(lc, animated: true, completion: nil)
    }
    @objc func profileCreate() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Must enter username")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard (user?.uid) != nil else {
                return
            }
            guard let uid = Auth.auth().currentUser?.uid else{
                return
            }
            let ref = Database.database().reference()
            let usersReference = ref.child("users").child(uid)
            
            let values = ["email": self.emailTextField.text, "fullname" : self.fullnameTextField.text, "username" : self.usernameTextField.text, "profileurl" : self.profileurl.text, "funding" : self.funding.text] as [String : AnyObject]
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err ?? "")
                    return
                }
            })
            
            let customtabbar = CustomTabBar()
            self.present(customtabbar, animated: true, completion: nil)
        })
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
