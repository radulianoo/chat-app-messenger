//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Octav Radulian on 10.03.2023.
//

import UIKit
//for log out we need to implement FirebaseAuth to call signOut()
import FirebaseAuth
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    //add the tableView to the UI
    @IBOutlet var tableView: UITableView!
    
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}

//add the delegate and the data source required methods
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows according with our data object
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeue a cell and provide the text and some basic layout
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //deselect the row when is tapped with animation
        tableView.deselectRow(at: indexPath, animated: true)
        //before the actual log out we will present an alert , so the user will be informed about the selected action
        let actionSheet = UIAlertController(title: "Sign Out",
                                      message: "You are about to sign out from the account",
                                      preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            
            guard let strongSelf = self else {
                return
            }
            
            
            //Log Out facebook
            FBSDKLoginKit.LoginManager().logOut()
            
            do {
                //log out the user
                try FirebaseAuth.Auth.auth().signOut()
                //if the user is logged out we need to present the login screen
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                ///by changing the animation to false it will take a shorter time to pop up
                strongSelf.present(nav, animated: true)
            }
            catch {
                print("Failed to log out.")
            }
        }))
        
        //if the user wants to quit the sign out action we will present this option
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
        
    }
    
}
    

