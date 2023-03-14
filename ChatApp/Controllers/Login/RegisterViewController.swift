//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Octav Radulian on 10.03.2023.
//

import UIKit
//also importing Firebase Auth (we will look now only for email&password)
import FirebaseAuth

class RegisterViewController: UIViewController {
    ///we will create more UI elements
    
    ///we want to show a logo on the top of the VC
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    ///a scroll view
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    ///firstNameField ->  textField
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First name"
        
        ///this is to correct the distance between the placeholder text and the border of the textfield
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    ///lastNameField textField
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last name"
        
        ///this is to correct the distance between the placeholder text and the border of the textfield
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    ///email textField
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email address"
        
        ///this is to correct the distance between the placeholder text and the border of the textfield
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        
        return field
    }()
    
    
    ///password textField
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password"
        
        ///this is to correct the distance between the placeholder text and the border of the textfield
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    ///the login button
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        
        ///we will add a button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        ///implement the delegate for the textfields
        emailField.delegate = self
        passwordField.delegate = self
        
        
        ///add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        ///in order for a new user to update his profile image (aka the mess logo right now)
        ///first we need to enable user interaction on the image
        ///after  add a gesture recognizer
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                            action: #selector(didTapChangeProfilePic))
        ///how many taps & touches are required by the user
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        
        imageView.addGestureRecognizer(gesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ///the frame of the scrollview is the entire screen
        scrollView.frame = view.bounds
        let size  = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        ///adjusting the corner radius of the image
        imageView.layer.cornerRadius = imageView.width/2.0
        
        
        ///adding the first & lastNameTextField
        firstNameField.frame = CGRect(x: 30,
                                      y: imageView.bottom + 20,
                                      width: scrollView.width - 60,
                                      height: 52)
        
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        ///this is for laying out the element on the screen
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        registerButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 20,
                                   width: scrollView.width - 60,
                                   height: 52)
    }
    
    ///the method for our gesture recognizer
    @objc private func didTapChangeProfilePic() {
        ///here we will implement for our user the possibility to take a pic or to select from library
        print("User is trying to change the profile pic")
        presentPhotoActionSheet()
    }
    
    
    ///once the registerButton is tapped we will make some text validation
    ///
    @objc private func registerButtonTapped() {
        
        ///if the login button is tapped then the email & password will resign it first responder
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count > 6 else {
            alertUserLoginError()
            return
        
        }
        
        //TO DO: Firebase Log In
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let result = authResult , error == nil else {
                print("Error creating user")
                return
            }
            
            let user = result.user
            print("Created User: \(user)")
        }
        
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to create a new account.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        present(alert, animated: true)
    }
    
    ///once the user taps the button we want to push the registerVC to the screen
    ///private keyword means that it can't be called from other classes
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        
        return true
    }
}

///after asking for acess to camera and photo album we need to create an extension
///and conform to the UIImagePickerControllerDelegate -> this will allow to select and take a picture
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    ///and we will create our function in order for the user to
    ///select from an action sheet to take a photo or to choose a photo from library
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to upload your profile photo?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            //photo , weak self to prevent a memory retention loop to be created
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Select from Photos", style: .default, handler: { [weak self] _ in
            //select , self is optional because is weak
            self?.presentPhotos()
        }))
        
        present(actionSheet, animated: true)
    }
    
    ///we will create two functions that will be called inside from the handler from action sheet
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:  true)
    }
    
    func presentPhotos() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:  true)
    }
    
    ///this is used when a user takes/selects a photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //to do
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
        
    }
    ///this is used when the user finishes
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //to do
        picker.dismiss(animated: true)
    }
    
}
