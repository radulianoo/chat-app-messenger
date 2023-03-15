//
//  ViewController.swift
//  ChatApp
//
//  Created by Octav Radulian on 10.03.2023.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///this is our initial view controller
        
        
        
    }
    ///here we will check if a user is already logged in
    ///based on user defaults data
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    ///now that we have firebase auth implemented
    ///we write this function for cases when the current user is now logged in or if it doesn't have a session saved
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            ///by changing the animation to false it will take a shorter time to pop up
            present(nav, animated: false)
        }
    }

}

