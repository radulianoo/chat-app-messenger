//
//  ViewController.swift
//  ChatApp
//
//  Created by Octav Radulian on 10.03.2023.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ///this is our initial view controller
        view.backgroundColor = .red
        
    }
    ///here we will check if a user is already logged in
    ///based on user defaults data
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        ///if user is not logged in present the loginVC with modal presentation style
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            ///by changing the animation to false it will take a shorter time to pop up
            present(nav, animated: false)
        }
    }

}

